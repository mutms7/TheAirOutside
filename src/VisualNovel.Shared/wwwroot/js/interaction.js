(function () {
    const bindings = new WeakMap();

    const clamp = (value, min = -1, max = 1) => Math.min(max, Math.max(min, value));
    const deadzone = (value) => {
        const abs = Math.abs(value);
        if (abs < 0.18) return 0;
        return Math.sign(value) * ((abs - 0.18) / 0.82);
    };

    const isTextInput = (target) => {
        if (!target) return false;
        const tag = target.tagName;
        return tag === "INPUT"
            || tag === "TEXTAREA"
            || tag === "SELECT"
            || target.isContentEditable;
    };

    const isButtonActivation = (event) =>
        event.target?.tagName === "BUTTON" && (event.key === "Enter" || event.key === " ");

    function bind(stage, dotNet) {
        if (!stage || bindings.has(stage)) return;

        const keys = new Set();
        const pointer = { x: 0, y: 0 };

        const updateLook = () => {
            const keyX = (keys.has("d") ? 1 : 0) - (keys.has("a") ? 1 : 0);
            const keyY = (keys.has("s") ? 1 : 0) - (keys.has("w") ? 1 : 0);
            stage.style.setProperty("--look-x", clamp(pointer.x + keyX * 0.95).toFixed(3));
            stage.style.setProperty("--look-y", clamp(pointer.y + keyY * 0.95).toFixed(3));
        };

        const invokeNavigation = async (method) => {
            try {
                await dotNet.invokeMethodAsync(method);
            } catch {
                // Component may have been disposed during navigation/reload.
            }
        };

        const onPointerMove = (event) => {
            const rect = stage.getBoundingClientRect();
            if (rect.width <= 0 || rect.height <= 0) return;
            pointer.x = deadzone(((event.clientX - rect.left) / rect.width) * 2 - 1);
            pointer.y = deadzone(((event.clientY - rect.top) / rect.height) * 2 - 1);
            updateLook();
        };

        const onPointerLeave = () => {
            pointer.x = 0;
            pointer.y = 0;
            updateLook();
        };

        const onKeyDown = (event) => {
            const key = event.key.toLowerCase();

            if (key === "escape") {
                event.preventDefault();
                dotNet.invokeMethodAsync("ToggleMenuFromInput").catch(() => { });
                return;
            }

            if (isTextInput(event.target) || isButtonActivation(event)) return;

            if (["w", "a", "s", "d"].includes(key)) {
                keys.add(key);
                updateLook();
                event.preventDefault();
                return;
            }

            if (event.repeat) return;

            if (event.key === "ArrowRight" || event.key === "ArrowDown" || event.key === " " || event.key === "Enter") {
                event.preventDefault();
                invokeNavigation("AdvanceFromInput");
                return;
            }

            if (event.key === "ArrowLeft" || event.key === "ArrowUp") {
                event.preventDefault();
                invokeNavigation("BackFromInput");
            }
        };

        const onKeyUp = (event) => {
            const key = event.key.toLowerCase();
            if (!["w", "a", "s", "d"].includes(key)) return;
            keys.delete(key);
            updateLook();
            event.preventDefault();
        };

        stage.addEventListener("pointermove", onPointerMove);
        stage.addEventListener("pointerleave", onPointerLeave);
        window.addEventListener("keydown", onKeyDown, { passive: false });
        window.addEventListener("keyup", onKeyUp, { passive: false });

        bindings.set(stage, {
            onPointerMove,
            onPointerLeave,
            onKeyDown,
            onKeyUp
        });

        updateLook();
    }

    function unbind(stage) {
        const binding = bindings.get(stage);
        if (!stage || !binding) return;
        stage.removeEventListener("pointermove", binding.onPointerMove);
        stage.removeEventListener("pointerleave", binding.onPointerLeave);
        window.removeEventListener("keydown", binding.onKeyDown);
        window.removeEventListener("keyup", binding.onKeyUp);
        bindings.delete(stage);
    }

    function closeApp() {
        try {
            window.open("", "_self");
            window.close();
        } catch {
            // Browsers often block close() for tabs they did not open.
        }

        window.setTimeout(() => {
            if (!document.hidden) {
                window.location.replace("about:blank");
            }
        }, 140);
    }

    window.visualNovelInput = { bind, unbind, closeApp };
})();

<?php

namespace ride\library\template\theme;

/**
 * Bootstrap template theme
 */
class BootstrapTheme implements Theme {

    /**
     * Gets the machine name of the theme
     * @return string
     */
    public function getName() {
        return 'bootstrap';
    }

    /**
     * Gets the display name of this theme
     * @return string
     */
    public function getDisplayName() {
        return ucfirst($this->getName());
    }

    /**
     * Gets the parent theme
     * @return string Machine name of the parent theme
     */
    public function getParent() {
        return null;
    }

    /**
     * Gets the machine name(s) of the available template engines
     * @return string|array
     */
    public function getEngines() {
        return 'smarty';
    }

}

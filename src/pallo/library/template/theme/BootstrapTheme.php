<?php

namespace pallo\library\template\theme;

/**
 * Interface for a template theme
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
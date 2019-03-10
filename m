Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FBCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD271206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCJU0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:26:08 -0400
Received: from smtp.220.in.ua ([89.184.67.205]:34957 "EHLO smtp.220.in.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfCJU0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:26:08 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Mar 2019 16:26:05 EDT
Received: from [192.168.202.100] (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id 1D7FB1A202F8;
        Sun, 10 Mar 2019 22:18:09 +0200 (EET)
Subject: Re: [PATCH 01/25] leds: class: Improve LED and LED flash class
 registration API
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-2-jacek.anaszewski@gmail.com>
From:   Oleh Kravchenko <oleg@kaa.org.ua>
Openpgp: preference=signencrypt
Autocrypt: addr=oleg@kaa.org.ua; prefer-encrypt=mutual; keydata=
 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
 WVdfrwbus0lVCELNSvCIW2IktSytUxjQfmjBMw==
Message-ID: <24877e3e-51ec-5c1a-3d2d-b3104b09189d@kaa.org.ua>
Date:   Sun, 10 Mar 2019 22:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190310182836.20841-2-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: uk-UA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for patches :)

10.03.19 20:28, Jacek Anaszewski пише:
> Replace of_led_classdev_register() with led_classdev_register_ext(), which
> accepts easily extendable struct led_init_data, instead of the fixed
> struct device_node argument. The latter can be now passed in a fwnode
> property of the struct led_init_data.
> 
> The modification is driven by the need for passing another argument
> to the LED class initialization function - a LED class device name.
> Currently it is conveyed in the "name" char pointer property of
> struct led_classdev, which is semantically and functionally incorrect
> since it is needed only on LED class device registration, but persists
> in system memory throughout the whole LED class device lifetime.
> 
> Whereas in case of the name strings coming from DT "label" property or
> statically initialized ones the cost is only the pointer size, it grows
> to LED_MAX_NAME_SIZE (64) with the advent of a new LED class device naming
> scheme, where color and function properties come from separate board
> firmware properties and the name needs to be constructed in a new buffer.
> 
> The change will not break any existing clients since the patch alters
> also existing led_classdev{_flash}_register() macro wrappers, that pass
> NULL in place of init_data, which leads to using legacy name
> initialization path basing on the struct led_classdev's "name" property.
> 
> Two existing users of devm_of_led_classdev_registers() are modified
> to use devm_led_classdev_register(), which will not impact their
> operation since they in fact didn't need to pass struct device_node on
> registration from the beginning.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Tested-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Dan Murphy <dmurphy@ti.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  drivers/leds/led-class-flash.c  |  9 +++++----
>  drivers/leds/led-class.c        | 34 ++++++++++++++++++++++------------
>  drivers/leds/leds-cr0014114.c   |  3 +--
>  drivers/leds/leds-gpio.c        |  2 +-
>  include/linux/led-class-flash.h | 15 ++++++++++-----
>  include/linux/leds.h            | 37 +++++++++++++++++++++++++++----------
>  6 files changed, 66 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
> index cf398275a53c..8d1c1177bb9a 100644
> --- a/drivers/leds/led-class-flash.c
> +++ b/drivers/leds/led-class-flash.c
> @@ -285,8 +285,9 @@ static void led_flash_init_sysfs_groups(struct led_classdev_flash *fled_cdev)
>  	led_cdev->groups = flash_groups;
>  }
>  
> -int led_classdev_flash_register(struct device *parent,
> -				struct led_classdev_flash *fled_cdev)
> +int led_classdev_flash_register_ext(struct device *parent,
> +				    struct led_classdev_flash *fled_cdev,
> +				    struct led_init_data *init_data)
>  {
>  	struct led_classdev *led_cdev;
>  	const struct led_flash_ops *ops;
> @@ -312,13 +313,13 @@ int led_classdev_flash_register(struct device *parent,
>  	}
>  
>  	/* Register led class device */
> -	ret = led_classdev_register(parent, led_cdev);
> +	ret = led_classdev_register_ext(parent, led_cdev, init_data);
>  	if (ret < 0)
>  		return ret;
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(led_classdev_flash_register);
> +EXPORT_SYMBOL_GPL(led_classdev_flash_register_ext);
>  
>  void led_classdev_flash_unregister(struct led_classdev_flash *fled_cdev)
>  {
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 3c7e3487b373..a8337e0e02ea 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -17,6 +17,7 @@
>  #include <linux/leds.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
> @@ -244,18 +245,25 @@ static int led_classdev_next_name(const char *init_name, char *name,
>  }
>  
>  /**
> - * of_led_classdev_register - register a new object of led_classdev class.
> + * led_classdev_register_ext - register a new object of led_classdev class
> + *			       with init data.
>   *
>   * @parent: parent of LED device
>   * @led_cdev: the led_classdev structure for this device.
> - * @np: DT node describing this LED
> + * @init_data: LED class device initialization data
>   */
> -int of_led_classdev_register(struct device *parent, struct device_node *np,
> -			    struct led_classdev *led_cdev)
> +int led_classdev_register_ext(struct device *parent,
> +			      struct led_classdev *led_cdev,
> +			      struct led_init_data *init_data)
>  {
>  	char name[LED_MAX_NAME_SIZE];
>  	int ret;
>  
> +	if (init_data && init_data->name)
> +		led_cdev->name = init_data->name;
> +	else
> +		dev_info(parent, "init_data not available");
> +
>  	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
>  	if (ret < 0)
>  		return ret;
> @@ -268,7 +276,8 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>  		mutex_unlock(&led_cdev->led_access);
>  		return PTR_ERR(led_cdev->dev);
>  	}
> -	led_cdev->dev->of_node = np;
> +	if (init_data && init_data->fwnode)
> +		led_cdev->dev->of_node = to_of_node(init_data->fwnode);
>  
>  	if (ret)
>  		dev_warn(parent, "Led %s renamed to %s due to name collision",
> @@ -313,7 +322,7 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(of_led_classdev_register);
> +EXPORT_SYMBOL_GPL(led_classdev_register_ext);
>  
>  /**
>   * led_classdev_unregister - unregisters a object of led_properties class.
> @@ -358,14 +367,15 @@ static void devm_led_classdev_release(struct device *dev, void *res)
>  }
>  
>  /**
> - * devm_of_led_classdev_register - resource managed led_classdev_register()
> + * devm_led_classdev_register_ext - resource managed led_classdev_register_ext()
>   *
>   * @parent: parent of LED device
>   * @led_cdev: the led_classdev structure for this device.
> + * @init_data: LED class device initialization data
>   */
> -int devm_of_led_classdev_register(struct device *parent,
> -				  struct device_node *np,
> -				  struct led_classdev *led_cdev)
> +int devm_led_classdev_register_ext(struct device *parent,
> +				   struct led_classdev *led_cdev,
> +				   struct led_init_data *init_data)
>  {
>  	struct led_classdev **dr;
>  	int rc;
> @@ -374,7 +384,7 @@ int devm_of_led_classdev_register(struct device *parent,
>  	if (!dr)
>  		return -ENOMEM;
>  
> -	rc = of_led_classdev_register(parent, np, led_cdev);
> +	rc = led_classdev_register_ext(parent, led_cdev, init_data);
>  	if (rc) {
>  		devres_free(dr);
>  		return rc;
> @@ -385,7 +395,7 @@ int devm_of_led_classdev_register(struct device *parent,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(devm_of_led_classdev_register);
> +EXPORT_SYMBOL_GPL(devm_led_classdev_register_ext);
>  
>  static int devm_led_classdev_match(struct device *dev, void *res, void *data)
>  {
> diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
> index 0e4262462cb9..1c82152764d2 100644
> --- a/drivers/leds/leds-cr0014114.c
> +++ b/drivers/leds/leds-cr0014114.c
> @@ -207,8 +207,7 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
>  		led->ldev.max_brightness	  = CR_MAX_BRIGHTNESS;
>  		led->ldev.brightness_set_blocking = cr0014114_set_sync;
>  
> -		ret = devm_of_led_classdev_register(priv->dev, np,
> -						    &led->ldev);
> +		ret = devm_led_classdev_register(priv->dev, &led->ldev);
>  		if (ret) {
>  			dev_err(priv->dev,
>  				"failed to register LED device %s, err %d",
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 998f2ff6914d..b26cf78993d1 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -112,7 +112,7 @@ static int create_gpio_led(const struct gpio_led *template,
>  	if (ret < 0)
>  		return ret;
>  
> -	return devm_of_led_classdev_register(parent, np, &led_dat->cdev);
> +	return devm_led_classdev_register(parent, &led_dat->cdev);
>  }
>  
>  struct gpio_leds_priv {
> diff --git a/include/linux/led-class-flash.h b/include/linux/led-class-flash.h
> index 700efaa9e115..ded8d9fa6149 100644
> --- a/include/linux/led-class-flash.h
> +++ b/include/linux/led-class-flash.h
> @@ -90,15 +90,20 @@ static inline struct led_classdev_flash *lcdev_to_flcdev(
>  }
>  
>  /**
> - * led_classdev_flash_register - register a new object of led_classdev class
> - *				 with support for flash LEDs
> - * @parent: the flash LED to register
> + * led_classdev_flash_register_ext - register a new object of LED class with
> + *				     init data and with support for flash LEDs
> + * @parent: LED flash controller device this flash LED is driven by
>   * @fled_cdev: the led_classdev_flash structure for this device
> + * @init_data: the LED class flash device initialization data
>   *
>   * Returns: 0 on success or negative error value on failure
>   */
> -extern int led_classdev_flash_register(struct device *parent,
> -				struct led_classdev_flash *fled_cdev);
> +extern int led_classdev_flash_register_ext(struct device *parent,
> +					struct led_classdev_flash *fled_cdev,
> +					struct led_init_data *init_data);
> +
> +#define led_classdev_flash_register(parent, fled_cdev)		\
> +	led_classdev_flash_register_ext(parent, fled_cdev, NULL)
>  
>  /**
>   * led_classdev_flash_unregister - unregisters an object of led_classdev class
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 5263f87e1d2c..bffb4315fd66 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -20,6 +20,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include <linux/workqueue.h>
> +#include <uapi/linux/uleds.h>
>  
>  struct device;
>  struct led_pattern;
> @@ -34,6 +35,13 @@ enum led_brightness {
>  	LED_FULL	= 255,
>  };
>  
> +struct led_init_data {
> +	/* Device fwnode handle */
> +	struct fwnode_handle *fwnode;
> +	/* Requested LED class device name */
> +	char name[LED_MAX_NAME_SIZE];
> +};
> +
>  struct led_classdev {
>  	const char		*name;
>  	enum led_brightness	 brightness;
> @@ -129,16 +137,25 @@ struct led_classdev {
>  	struct mutex		led_access;
>  };
>  
> -extern int of_led_classdev_register(struct device *parent,
> -				    struct device_node *np,
> -				    struct led_classdev *led_cdev);
> -#define led_classdev_register(parent, led_cdev)				\
> -	of_led_classdev_register(parent, NULL, led_cdev)
> -extern int devm_of_led_classdev_register(struct device *parent,
> -					 struct device_node *np,
> -					 struct led_classdev *led_cdev);
> -#define devm_led_classdev_register(parent, led_cdev)			\
> -	devm_of_led_classdev_register(parent, NULL, led_cdev)
> +/**
> + * led_classdev_register_ext - register a new object of LED class with
> + *			       init data
> + * @parent: LED controller device this LED is driven by
> + * @led_cdev: the led_classdev structure for this device
> + * @init_data: the LED class device initialization data
> + *
> + * Returns: 0 on success or negative error value on failure
> + */
> +extern int led_classdev_register_ext(struct device *parent,
> +				     struct led_classdev *led_cdev,
> +				     struct led_init_data *init_data);
> +#define led_classdev_register(parent, led_cdev)			\
> +	led_classdev_register_ext(parent, led_cdev, NULL)
> +extern int devm_led_classdev_register_ext(struct device *parent,
> +					  struct led_classdev *led_cdev,
> +					  struct led_init_data *init_data);
> +#define devm_led_classdev_register(parent, led_cdev)		\
> +	devm_led_classdev_register_ext(parent, led_cdev, NULL)
>  extern void led_classdev_unregister(struct led_classdev *led_cdev);
>  extern void devm_led_classdev_unregister(struct device *parent,
>  					 struct led_classdev *led_cdev);
> 

-- 
Best regards,
Oleh Kravchenko
Phone: +380972763224 | oleg@kaa.org.ua | Skype: oleg_krava

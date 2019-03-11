Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1530C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A2A2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s+HdsXnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCKR1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:27:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41236 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:27:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2BHR58i066354;
        Mon, 11 Mar 2019 12:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552325225;
        bh=OnPFerda0jQWM66jxTxChk2fsMMxy1ilbLhi9i/3Kj4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s+HdsXnbOVP5L+FQGeI6DlHcb8dGzEON93vx+Qf3rF0gkui2lUbHOJSKvgu244eCH
         vhhrcQBUWKeHzUEYaABDoOKcjfX3gqSeaR5LnEdvO7t2pn1ObtDocMSGviSBWpdwhp
         yfV2iNlh+OpNi2sOhmgzkiEg6y8Ud9dvS3rAwDLo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2BHR5CD062213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 12:27:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Mar 2019 12:27:04 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Mar 2019 12:27:04 -0500
Received: from [172.22.80.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2BHR3KG015074;
        Mon, 11 Mar 2019 12:27:04 -0500
Subject: Re: [PATCH 11/25] leds: lp8860: Use led_compose_name()
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-12-jacek.anaszewski@gmail.com>
 <cf42384b-cdbc-3ad7-468f-c4036579652f@ti.com>
 <7242a6e9-ece7-22af-4d62-f2a6aa163579@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7df54f37-1cd4-b1d7-78f2-0aea894f6543@ti.com>
Date:   Mon, 11 Mar 2019 12:26:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7242a6e9-ece7-22af-4d62-f2a6aa163579@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 3/11/19 12:24 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 3/11/19 1:28 PM, Dan Murphy wrote:
>> On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
>>> Switch to using generic LED support for composing LED class
>>> device name.
>>>
>>> While at it, avoid iterating through available child of nodes
>>> in favor of obtaining single expected child node using single
>>> call to of_get_next_available_child().
>>>
>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>   drivers/leds/leds-lp8860.c | 38 +++++++++++++++++++-------------------
>>>   1 file changed, 19 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
>>> index 39c72a908f3b..7c12ccdc1f2f 100644
>>> --- a/drivers/leds/leds-lp8860.c
>>> +++ b/drivers/leds/leds-lp8860.c
>>> @@ -22,7 +22,6 @@
>>>   #include <linux/of_gpio.h>
>>>   #include <linux/gpio/consumer.h>
>>>   #include <linux/slab.h>
>>> -#include <uapi/linux/uleds.h>
>>>     #define LP8860_DISP_CL1_BRT_MSB        0x00
>>>   #define LP8860_DISP_CL1_BRT_LSB        0x01
>>> @@ -87,6 +86,8 @@
>>>     #define LP8860_CLEAR_FAULTS        0x01
>>>   +#define LP8860_NAME            "lp8860"
>>> +
>>>   /**
>>>    * struct lp8860_led -
>>>    * @lock - Lock for reading/writing the device
>>> @@ -96,7 +97,6 @@
>>>    * @eeprom_regmap - EEPROM register map
>>>    * @enable_gpio - VDDIO/EN gpio to enable communication interface
>>>    * @regulator - LED supply regulator pointer
>>> - * @label - LED label
>>>    */
>>>   struct lp8860_led {
>>>       struct mutex lock;
>>> @@ -106,7 +106,6 @@ struct lp8860_led {
>>>       struct regmap *eeprom_regmap;
>>>       struct gpio_desc *enable_gpio;
>>>       struct regulator *regulator;
>>> -    char label[LED_MAX_NAME_SIZE];
>>>   };
>>>     struct lp8860_eeprom_reg {
>>> @@ -387,25 +386,26 @@ static int lp8860_probe(struct i2c_client *client,
>>>       struct lp8860_led *led;
>>>       struct device_node *np = client->dev.of_node;
>>>       struct device_node *child_node;
>>> -    const char *name;
>>> +    struct led_init_data init_data;
>>>         led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
>>>       if (!led)
>>>           return -ENOMEM;
>>>   -    for_each_available_child_of_node(np, child_node) {
>>> -        led->led_dev.default_trigger = of_get_property(child_node,
>>> -                            "linux,default-trigger",
>>> -                            NULL);
>>> -
>>> -        ret = of_property_read_string(child_node, "label", &name);
>>> -        if (!ret)
>>> -            snprintf(led->label, sizeof(led->label), "%s:%s",
>>> -                 id->name, name);
>>> -        else
>>> -            snprintf(led->label, sizeof(led->label),
>>> -                "%s::display_cluster", id->name);
>>> -    }
>>> +    child_node = of_get_next_available_child(np, NULL);
>>
>> Again this device has multiple outputs that can be banked or separated.
>>
>> I would prefer to leave the iteration and just change the name generation.
> 
> In [0] you agreed on removing that. This code is simply broken since
> there is only one instance of struct lp8860_led allocated.
> 

Thanks for the reminder on my ack

Dan

>>> +    if (!child_node)
>>> +        return -EINVAL;
>>> +
>>> +    init_data.fwnode = of_fwnode_handle(child_node),
>>> +
>>> +    led->led_dev.default_trigger = of_get_property(child_node,
>>> +                        "linux,default-trigger",
>>> +                        NULL);
>>> +
>>> +    ret = led_compose_name(init_data.fwnode, LP8860_NAME,
>>> +                   ":display_cluster", init_data.name);
>>> +    if (ret)
>>> +        return ret;
>>>         led->enable_gpio = devm_gpiod_get_optional(&client->dev,
>>>                              "enable", GPIOD_OUT_LOW);
>>> @@ -420,7 +420,6 @@ static int lp8860_probe(struct i2c_client *client,
>>>           led->regulator = NULL;
>>>         led->client = client;
>>> -    led->led_dev.name = led->label;
>>>       led->led_dev.brightness_set_blocking = lp8860_brightness_set;
>>>         mutex_init(&led->lock);
>>> @@ -447,7 +446,8 @@ static int lp8860_probe(struct i2c_client *client,
>>>       if (ret)
>>>           return ret;
>>>   -    ret = devm_led_classdev_register(&client->dev, &led->led_dev);
>>> +    ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
>>> +                         &init_data);
>>>       if (ret) {
>>>           dev_err(&client->dev, "led register err: %d\n", ret);
>>>           return ret;
>>>
>>
>>
> 
> [0] https://lkml.org/lkml/2018/11/12/2231
> 


-- 
------------------
Dan Murphy

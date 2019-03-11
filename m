Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E6120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfCKLEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:04:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35930 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKLEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:04:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id g18so1169316wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 04:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQOozje+JqZS/zU5rN+HRC3QFg3kpZleOyD/h83UbzI=;
        b=ZoRTv+G+cdIP4irLXQZBYpReFAMLQhUMxmD5mYRCAZ7FHGXuTJ3mr/n/oF6eAGFPWz
         P7Ijq8V4+VjOQfCkWQXM3cQaooXg2WQg53ty+wQ5Kl/bekJdMfDPctEIyedTwdA0m3B1
         6Hk5bjfIuI+tsjSd31AupaGvx7DHxVernPXsHb1k98cSdO1/ygtpKjeqU/O43hBZMsUL
         g/Bepw1bhpoU7MkiC57j4WaO6hBo6rwKtjb9eV7w0INm/yBZvII/qbWt/6ksml/1MGW6
         iY0UmwOCQAFLBswdHeveb+gScet2tvFpXf1e1YlTIoPFcSrDuShqgPCT/8vATLZe2bNV
         gLKQ==
X-Gm-Message-State: APjAAAVbkR/SsdifME43ahsxBSaC1MQaWzRWPOtQYPwSKaZG2LqXOmOc
        UgJoMORWKocfzlXeeWGyb9S2Ig==
X-Google-Smtp-Source: APXvYqw2is601vzcu5lnaZ1HNrX/8uZfZiCUMHYtjGGfhkSIfG+3Kd8Biq7NV/oFkmUIN9VT2BzQUQ==
X-Received: by 2002:a5d:53cd:: with SMTP id a13mr20045691wrw.146.1552302244960;
        Mon, 11 Mar 2019 04:04:04 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y5sm16172109wmg.31.2019.03.11.04.04.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 04:04:04 -0700 (PDT)
Subject: Re: [PATCH 1/5] dt-bindings: connector: add optional properties for
 Type-B
From:   Hans de Goede <hdegoede@redhat.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
 <1552025622-15582-2-git-send-email-chunfeng.yun@mediatek.com>
 <693b11e7-fa9e-ab1f-561a-beb758b1872f@redhat.com>
 <1552282383.10179.21.camel@mhfsdcap03>
 <c8084259-74d3-c85f-1275-854826c935a0@redhat.com>
 <3684aa62-68ad-13ef-7c6e-2b57f7cd62b8@redhat.com>
Message-ID: <e5eed281-ee9b-6e1c-caea-1372329316be@redhat.com>
Date:   Mon, 11 Mar 2019 12:04:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3684aa62-68ad-13ef-7c6e-2b57f7cd62b8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-03-19 12:00, Hans de Goede wrote:
> Hi,
> 
> On 11-03-19 09:06, Hans de Goede wrote:
>> Hi,
>>
>> On 11-03-19 06:33, Chunfeng Yun wrote:
>>> Hi,
>>>
>>> On Fri, 2019-03-08 at 13:07 +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 08-03-19 07:13, Chunfeng Yun wrote:
>>>>> Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
>>>>> usb-b-connector
>>>>>
>>>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>>>> ---
>>>>>    .../devicetree/bindings/connector/usb-connector.txt    | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>>> index a9a2f2fc44f2..7a07b0f4f973 100644
>>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>>> @@ -17,6 +17,16 @@ Optional properties:
>>>>>    - self-powered: Set this property if the usb device that has its own power
>>>>>      source.
>>>>> +Optional properties for usb-b-connector:
>>>>> +- id-gpios: gpio for USB ID pin.
>>>>
>>>> What about boards where the ID pin is *not* connected to a GPIO,
>>>> but e.g. to a special pin on the PMIC which can also detect
>>>> an ACA adapter ? Currently this case is handled by extcon
>>>> drivers, but we have no way to set e.g. vbus-supply for the
>>>> connector. Maybe in this case the usb-connector node should
>>>> be a child of the PMIC node ?
>>> Yes, it would be, PMIC is in charger of detecting the status of ID pin
>>
>> Ok, then I think this should be documented too.
>>
>>>> And in many cases there also is a mux to switch the datalines
>>>> between the host and device(gadget) controllers, how should
>>>> that be described in this model?  See the new usb-role-switch
>>>> code under drivers/usb/roles
>>>>
>>>> In some cases the mux is controlled through a gpio, so we
>>>> may want to add a "mux-gpios" here in which case we also
>>>> need to define what 0/1 means.
>>> I'm not sure, the mux seems not belong to this connector,
>>> and may need another driver to register usb-role-switch,
>>> similar to:
>>>
>>> [v2,2/2] usb: typec: add typec switch via GPIO control
>>> https://patchwork.kernel.org/patch/10834327/
>>
>> Right the mux/role-switch will need a driver, but the "owner"
>> of the usb_connector, e.g. the PMIC or the owner of the
>> id GPIO pin needs to know which device is the role-switch so
>> that it can set the role correctly based on the id-pin.
>>
>> Your binding already contains Vbus info, allowing the owner
>> of the usb_connector to enable/disable Vbus based on the id-pin,
>> but the owner will also be responsible for setting the role-switch.
>>
>> Note we cannot simply assume there will be only one role-switch,
>> we really need some link from the usb_connector to the role-switch
>> (or if it is a GPIO driven role-switch simply a role-switch-gpios
>> member in the usb_connector).
> 
> I see now in your "[PATCH v3 1/2] dt-bindings: usb: add documentation for
> typec switch via GPIO" that you plan to use a
> Documentation/devicetree/bindings/graph.txt style binding for this,
> adding a remote-endpoint to the orientation-switch (in that patch), or
> to the role-switch.
> 
> But a Type-C port can have both an orientation-switch and a role-switch
> (and a mux if it supports e.g. DP-altmode), how is the driver driving
> the device which has the actual usb_c_connecter child-node to which
> the remote-endpoints for both the orientation- and the role-switch points
> supposed to figure out which is which ?
> 
> Also it feels the wrong-way around to me to have the orientation-switch
> point to the usb_c_connector, to me it would make more sense to have
> the usb_c_connector point to a port on the orientation-switch.

I just noticed you put an "orientation-switch" bool property in the device
which has the orientation-switch property, if we do something similar for
the role-switch then that should solve this.

Regards,

Hans

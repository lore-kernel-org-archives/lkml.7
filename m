Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC29206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfCKLAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:00:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39847 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfCKLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:00:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id z84so3797253wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 04:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCnTSCtxXAWQzg0NoAwSXilAgObaVi1CrMaTl57GpNM=;
        b=f0Iovj2FZFxqORbSR1TebdSGeHcEcvKO3Ljiv6+AX7IiPDmGg1iT3D9lr7R+oYXHD5
         Pdg0dEyUJc7i+NsuI6PJj1oF9XE+CiE3TnTPMmxXHHIc8fFylccrMSHDRWkmp3ClRXT7
         jUC6tO0i+zfx3dl+gKWBAl6/lbleNPz/ANAjCeGpMFmY3phdTPfH1NUdD2DJPnL9xnhT
         zC4zq8HhNjhGmNqUPqFBGsv/jxAkLVN7YM/Hw5V1LnQfZCY8L/K82lRYPFV2LguvjfLy
         dQffCiipkd1+rBFeZjap8oPACxcc/T3oSaKhcldXOdcWhm4GUf4+7HAdsR/w3Nv5TGS8
         cK0A==
X-Gm-Message-State: APjAAAUG2bBb+3Xp+WoE1Zpx0v86ZvQWK/YQWuihbaNKhj2u8frL6Oj/
        EHcmKk79bfkKEC8RVDY2TNlH0w==
X-Google-Smtp-Source: APXvYqyIhbXpeicb0xXJCChgjU8qVzqjzM7R1EkUporyfPDJnW2+1wwQfMTy/LS5CQ52I7lVqFTViA==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr17363420wmi.75.1552302011846;
        Mon, 11 Mar 2019 04:00:11 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p68sm25042699wme.45.2019.03.11.04.00.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 04:00:11 -0700 (PDT)
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
Message-ID: <3684aa62-68ad-13ef-7c6e-2b57f7cd62b8@redhat.com>
Date:   Mon, 11 Mar 2019 12:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c8084259-74d3-c85f-1275-854826c935a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-03-19 09:06, Hans de Goede wrote:
> Hi,
> 
> On 11-03-19 06:33, Chunfeng Yun wrote:
>> Hi,
>>
>> On Fri, 2019-03-08 at 13:07 +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 08-03-19 07:13, Chunfeng Yun wrote:
>>>> Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
>>>> usb-b-connector
>>>>
>>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>>> ---
>>>>    .../devicetree/bindings/connector/usb-connector.txt    | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> index a9a2f2fc44f2..7a07b0f4f973 100644
>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> @@ -17,6 +17,16 @@ Optional properties:
>>>>    - self-powered: Set this property if the usb device that has its own power
>>>>      source.
>>>> +Optional properties for usb-b-connector:
>>>> +- id-gpios: gpio for USB ID pin.
>>>
>>> What about boards where the ID pin is *not* connected to a GPIO,
>>> but e.g. to a special pin on the PMIC which can also detect
>>> an ACA adapter ? Currently this case is handled by extcon
>>> drivers, but we have no way to set e.g. vbus-supply for the
>>> connector. Maybe in this case the usb-connector node should
>>> be a child of the PMIC node ?
>> Yes, it would be, PMIC is in charger of detecting the status of ID pin
> 
> Ok, then I think this should be documented too.
> 
>>> And in many cases there also is a mux to switch the datalines
>>> between the host and device(gadget) controllers, how should
>>> that be described in this model?  See the new usb-role-switch
>>> code under drivers/usb/roles
>>>
>>> In some cases the mux is controlled through a gpio, so we
>>> may want to add a "mux-gpios" here in which case we also
>>> need to define what 0/1 means.
>> I'm not sure, the mux seems not belong to this connector,
>> and may need another driver to register usb-role-switch,
>> similar to:
>>
>> [v2,2/2] usb: typec: add typec switch via GPIO control
>> https://patchwork.kernel.org/patch/10834327/
> 
> Right the mux/role-switch will need a driver, but the "owner"
> of the usb_connector, e.g. the PMIC or the owner of the
> id GPIO pin needs to know which device is the role-switch so
> that it can set the role correctly based on the id-pin.
> 
> Your binding already contains Vbus info, allowing the owner
> of the usb_connector to enable/disable Vbus based on the id-pin,
> but the owner will also be responsible for setting the role-switch.
> 
> Note we cannot simply assume there will be only one role-switch,
> we really need some link from the usb_connector to the role-switch
> (or if it is a GPIO driven role-switch simply a role-switch-gpios
> member in the usb_connector).

I see now in your "[PATCH v3 1/2] dt-bindings: usb: add documentation for
typec switch via GPIO" that you plan to use a
Documentation/devicetree/bindings/graph.txt style binding for this,
adding a remote-endpoint to the orientation-switch (in that patch), or
to the role-switch.

But a Type-C port can have both an orientation-switch and a role-switch
(and a mux if it supports e.g. DP-altmode), how is the driver driving
the device which has the actual usb_c_connecter child-node to which
the remote-endpoints for both the orientation- and the role-switch points
supposed to figure out which is which ?

Also it feels the wrong-way around to me to have the orientation-switch
point to the usb_c_connector, to me it would make more sense to have
the usb_c_connector point to a port on the orientation-switch.

Regards,

Hans


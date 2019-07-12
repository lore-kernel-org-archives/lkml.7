Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E712FC742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C6920645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfGLMnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:43:45 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49266 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfGLMno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:43:44 -0400
Received: from [167.98.27.226] (helo=[10.35.6.255])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hlutl-0005uA-Hz; Fri, 12 Jul 2019 13:43:37 +0100
Subject: Re: [PATCH v1 08/11] dt-bindings: display/bridge: Add bindings for
 ti949
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-9-michael.drake@codethink.co.uk>
 <20190611181351.GW5016@pendragon.ideasonboard.com>
From:   Michael Drake <michael.drake@codethink.co.uk>
Message-ID: <534c485b-2074-1fcc-2d8f-11e5a9f278e4@codethink.co.uk>
Date:   Fri, 12 Jul 2019 13:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190611181351.GW5016@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 11/06/2019 19:13, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.

My pleasure, and thank you for the feedback!

> On Tue, Jun 11, 2019 at 03:04:09PM +0100, Michael Drake wrote:
>> Adds device tree bindings for:
>>
>>   TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer
>>
>> It supports instantiation via device tree / ACPI table.
>>
>> The device has the compatible string "ti,ds90ub949", and
>> and allows an arrray of strings to be provided as regulator
>> names to enable for operation of the device.
> 
> All the comments I made regarding the ds90ub948 DT bindings apply here
> too. Same for the comments related to the driver, they apply to the
> subsequent patches in this series.

OK, understood.

Thank you very much for the review.

>> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>>  .../bindings/display/bridge/ti,ds90ub949.txt  | 24 +++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
>> new file mode 100644
>> index 000000000000..3ba3897d5e81
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
>> @@ -0,0 +1,24 @@
>> +TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer
>> +============================================================
>> +
>> +This is the binding for Texas Instruments DS90UB949-Q1 bridge serializer.
>> +
>> +This device supports I2C only.
>> +
>> +Required properties:
>> +
>> +- compatible: "ti,ds90ub949"
>> +
>> +Optional properties:
>> +
>> +- regulators: List of regulator name strings to enable for operation of device.
>> +
>> +Example
>> +-------
>> +
>> +ti949: ds90ub949@0 {
>> +	compatible = "ti,ds90ub949";
>> +
>> +	regulators: "vcc",
>> +	            "vcc_hdmi";
>> +};
> 

-- 
Michael Drake                 https://www.codethink.co.uk/

Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898F0C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A4A206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="bjxLW+sP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLIXgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:36:38 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:56585 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLIXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:36:38 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0534D2304C;
        Tue, 10 Dec 2019 00:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575934595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqlqDgTrUF8m0l8xqUJYIm+ik5RFHnl42VQQb0xXi7I=;
        b=bjxLW+sPWEK7WeWOIY606r8n4GipH/td/6FHAH/LxRDy1VPJ/Z3Kr69ZE+x+d2AwcJnY8J
        w+c3U7hukOn2R/7IJhlL36/rRK0bJjzh5f0jmbJ1TR/MJrHdazBxa3ofeECCN8rmkJ1x50
        ELGBJpOFUR5yln4VBP+2hMrgl93Lrig=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Dec 2019 00:36:34 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: document the fsl-sai driver
In-Reply-To: <e28881421014b641c37fc2cacdf6c43e@walle.cc>
References: <20191122235622.8818-1-michael@walle.cc>
 <20191205151648.GA5680@bogus> <e28881421014b641c37fc2cacdf6c43e@walle.cc>
Message-ID: <95bfe66ecf86baf70818d287900d87f1@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 0534D2304C
X-Spamd-Result: default: False [-0.10 / 15.00];
         TO_DN_SOME(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.744]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-12-06 02:23, schrieb Michael Walle:
> Am 2019-12-05 16:16, schrieb Rob Herring:
>> On Sat, Nov 23, 2019 at 12:56:21AM +0100, Michael Walle wrote:
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>>  .../bindings/clock/fsl,sai-clock.yaml         | 48 
>>> +++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>>  create mode 100644 
>>> Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
>>> 
>>> diff --git 
>>> a/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml 
>>> b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
>>> new file mode 100644
>>> index 000000000000..7116c8bc24d3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
>>> @@ -0,0 +1,48 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>> 
>> Dual license new bindings please: (GPL-2.0-only OR BSD-2-Clause)
> 
> sure.
> 
>> 
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> http://devicetree.org/schemas/bindings/clock/fsl,sai-clock.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Freescale SAI bitclock-as-a-clock binding
>>> +
>>> +maintainers:
>>> +  - Michael Walle <michael@walle.cc>
>>> +
>>> +description: |
>>> +  It is possible to use the BCLK pin of a SAI module as a generic 
>>> clock
>>> +  output. Some SoC are very constrained in their pin multiplexer
>>> +  configuration. Eg. pins can only be changed groups. For example, 
>>> on the
>>> +  LS1028A SoC you can only enable SAIs in pairs. If you use only one 
>>> SAI,
>>> +  the second pins are wasted. Using this binding it is possible to 
>>> use the
>>> +  clock of the second SAI as a MCLK clock for an audio codec, for 
>>> example.
>>> +
>>> +  This is a composite of a gated clock and a divider clock.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: fsl,vf610-sai-clock
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  '#clock-cells':
>>> +    const: 0
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - '#clock-cells'
>>> +
>> 
>> Add:
>> 
>> additionalProperties: false
> 
> ok.
> 
>>> +examples:
>>> +  - |
>>> +    mclk: clock-mclk@f130080 {
>>> +        compatible = "fsl,vf610-sai-clock";
>>> +        reg = <0x0 0xf130080 0x0 0x80>;
>> 
>> Examples are built now and this will fail because the default
>> #address-cells and #size-cells are 1.
> 
> Mh, I've run the make dt_binding_check on this. It wasn't flagged,
> but I guess thats because its interpreted as two resources.
> 
> I haven't found anything how you can change the default. Or do you
> mean I should change the example to just use one address cell and
> one size cell? But then how would that work for examples (on other
> bindings) where there should be size-cells = <0> for example.

I guess I've answered that question myself, see the v2 patch series.
https://lore.kernel.org/lkml/20191209233305.18619-1-michael@walle.cc/

Thanks for the review.

> 
>> 
>>> +        #clock-cells = <0>;
>>> +        clocks = <&parentclk>;
>>> +    };
>>> --
>>> 2.20.1
>>> 

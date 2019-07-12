Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB9BC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD4F20989
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfGLUSm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:18:42 -0400
Received: from atlmailgw2.ami.com ([63.147.10.42]:50845 "EHLO
        atlmailgw2.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGLUSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:18:41 -0400
X-AuditID: ac10606f-d27ff70000003324-2c-5d28eb20fe7f
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw2.ami.com (Symantec Messaging Gateway) with SMTP id 2A.D9.13092.02BE82D5; Fri, 12 Jul 2019 16:18:40 -0400 (EDT)
Received: from ATLMS2.us.megatrends.com ([fe80::29dc:a91e:ea0c:cdeb]) by
 atlms1.us.megatrends.com ([fe80::8c55:daf0:ef05:5605%12]) with mapi id
 14.03.0415.000; Fri, 12 Jul 2019 16:18:40 -0400
From:   Hongwei Zhang <Hongweiz@ami.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
Thread-Topic: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
Thread-Index: AQHVMdoYoxHDUhbFgEKYqLGYV+TuK6bDajmAgAQPB2A=
Date:   Fri, 12 Jul 2019 20:18:39 +0000
Message-ID: <14D3C8298A3B0F42A1EB31EE961CFF82AA8F46AD@atlms2.us.megatrends.com>
References: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
 <9c998f5f-42ef-43bd-b024-839ee00126de@www.fastmail.com>
In-Reply-To: <9c998f5f-42ef-43bd-b024-839ee00126de@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.100.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWyRiBhgq7Ca41Yg2ddlha7LnNYzD9yjtXi
        9/m/zBZT/ixnsmhefY7Z4vKuOWwWS69fZLJo3XuE3YHD42r7LnaPNfPWMHpc/HiM2WPTqk42
        jzvX9rB5nJ+xkNHj8ya5APYoLpuU1JzMstQifbsEroyJXbeZCnZLV8y/+4utgXGeWBcjJ4eE
        gInE77YNLCC2kMAuJonpTZVdjFxA9mFGiRsHJrOCJNgE1CSe/mlgB0mICKxhlLh59igjiMMs
        cJZRYs2lL8wgVcICPhInfi4HGyUi4CvRfaaFEcK2kthwpRksziKgKvHg8H8mEJtXwF/iat8M
        dojVVRIrdveAbeMUcJFYMm0LG4jNKCAm8f3UGrB6ZgFxiVtP5jNBnC0gsWTPeWYIW1Ti5eN/
        rBC2kkTDin9Q9ToSC3Z/YoOwtSWWLXzNDLFXUOLkzCcsExhFZyEZOwtJyywkLbOQtCxgZFnF
        KJRYkpObmJmTXm6kl5ibqZecn7uJERKP+TsYP340P8TIxMF4iFGCg1lJhHfVf/VYId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4ryr1nyLERJITyxJzU5NLUgtgskycXBKNTDOuNgu7FYhZ62Vr6Pq
        paWRFbEkjbs2XfKugNzi21e3xUjVbLjafTqRc3HIdtGHGWXSfLwpk/dmy91riZzT2Lfkg/vV
        fxaJzdebb7861LTeOGKN49vGJ3Vbvn9TvLlxxb4XpQaHNl1TS34WsVFsVZl5hPgsbbfv5V8c
        GR9tV9GYu2/Z4d9hn/mVWIozEg21mIuKEwGO1G0stQIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review, Andrew,

Just submitted an updated binding document, with new proper subject line:

[PATCH 2/3 v2] dt-bindings: gpio: aspeed: Add SGPIO support

Regards,
--Hongwei

-----Original Message-----
From: Andrew Jeffery <andrew@aj.id.au> 
Sent: Tuesday, July 9, 2019 10:16 PM
To: Hongwei Zhang <Hongweiz@ami.com>; devicetree@vger.kernel.org; Joel Stanley <joel@jms.id.au>; Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
Subject: Re: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support



On Thu, 4 Jul 2019, at 05:31, Hongwei Zhang wrote:
> Add bindings to support SGPIO on AST2400 or AST2500.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> new file mode 100644
> index 0000000..f5fc6ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
> @@ -0,0 +1,36 @@
> +Aspeed SGPIO controller Device Tree Bindings
> +-------------------------------------------
> +
> +Required properties:
> +- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
> +
> +- #gpio-cells 		: Should be two
> +			  - First cell is the GPIO line number
> +			  - Second cell is used to specify optional
> +			    parameters (unused)
> +
> +- reg			: Address and length of the register set for the device
> +- gpio-controller	: Marks the device node as a GPIO controller.
> +- interrupts		: Interrupt specifier (see interrupt bindings for
> +			  details)
> +- interrupt-controller	: Mark the GPIO controller as an 
> interrupt-controller

As this is a serial GPIO controller, a critical piece of configuration information is how many GPIOs we wish to serialise. This is done in multiples of 8, up to 80 pins.

The bindings need to describe the "ngpios" property from the generic GPIO bindings and how this affects the behaviour of the controller.

We also need to add the "bus-frequency" property here to control the rate of SGPMCK.

> +
> +Optional properties:
> +
> +- clocks                : A phandle to the clock to use for debounce 
> timings

We need this, but not for the reason specified, and it should be a required property. We need PCLK (the APB clock) to derive the SGPIO bus frequency. Despite what the datasheet blurb says, there's no debounce control for the SGPIO master (this is a copy/paste mistake from the description of the parallel GPIO master).

> +
> +The sgpio and interrupt properties are further described in their
> respective
> +bindings documentation:
> +
> +- Documentation/devicetree/bindings/sgpio/gpio.txt
> +- 
> +Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +  Example:
> +	sgpio@1e780200 {
> +		#gpio-cells = <2>;
> +		compatible = "aspeed,ast2500-sgpio";
> +		gpio-controller;
> +		interrupts = <40>;
> +		reg = <0x1e780200 0x0100>;
> +		interrupt-controller;
> +	};

You'll need to fix up the example after making the changes mentioned above.

Andrew

> --
> 2.7.4
> 
>

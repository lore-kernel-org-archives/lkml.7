Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC06ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95BF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F/02A//E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbfJWD5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:57:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfJWD5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vhnNfgbyvwy7UCyN7x40j7OcT7i5pKApwS9FpVwzmEE=; b=F/02A//E4yisXmCcnOCo5WoJn
        7LnD8pB7EWXenQI56WuP9oOgjVzfs7Dy7qLDP4T9Y6p1eX4KZJq1nWweGP3ghpN9CMm1WBdP+G2TQ
        H/puuhvr3MRGWZLdepMOiRNKe46rXd/4g5TLs50sJtKAnq2U0uOYEqqBDjOQA93EcMJ7UsYFerx/z
        ZmJyrsngkTzZxCaHFhTtiC2Z4VOEqIgqCEddF0anKls34Ubeo8y4vNMYbUl9xKgICGjd+wUj1eDpa
        omPdObRdXVTl2/k6z4FOuiGdtDpqoyJr2KdYr7EN/AqHmCPjagYYlF3rHnFqBRPwyuU6j4yCsi2KD
        kL6BqfOUg==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iN7lO-00050V-R5; Wed, 23 Oct 2019 03:56:46 +0000
Subject: Re: [RFC] docs: add a reset controller chapter to the driver API docs
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
References: <20191022164547.22632-1-p.zabel@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e964179-4515-33ea-bdc4-f27daa311267@infradead.org>
Date:   Tue, 22 Oct 2019 20:56:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022164547.22632-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/19 9:45 AM, Philipp Zabel wrote:
> Add initial reset controller API documentation. This is mostly indented

                                                                 intended

> to describe the concepts to users of the consumer API, and to tie the
> kerneldoc comments we already have into the driver API documentation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  Documentation/driver-api/index.rst |   1 +
>  Documentation/driver-api/reset.rst | 217 +++++++++++++++++++++++++++++
>  2 files changed, 218 insertions(+)
>  create mode 100644 Documentation/driver-api/reset.rst
> 


> diff --git a/Documentation/driver-api/reset.rst b/Documentation/driver-api/reset.rst
> new file mode 100644
> index 000000000000..210ccd97c5f0
> --- /dev/null
> +++ b/Documentation/driver-api/reset.rst
> @@ -0,0 +1,217 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +====================
> +Reset controller API
> +====================
> +
> +Introduction
> +============
> +
> +Reset controllers are central units that control the reset signals to multiple
> +peripherals.
> +The reset controller API is split in two parts:

                 I prefer            into two parts:

> +the `consumer driver interface <#consumer-driver-interface>`__ (`API reference
> +<#reset-consumer-api>`__), which allows peripheral drivers to request control
> +over their reset input signals, and the `reset controller driver interface
> +<#reset-controller-driver-interface>`__ (`API reference
> +<#reset-controller-driver-api>`__), which is used by drivers for reset
> +controller devices to register their reset controls to provide them to the
> +consumers.
> +
> +While some reset controller hardware units also implement system restart
> +functionality, restart handlers are out of scope for the reset controller API.
> +
> +Glossary
> +--------
> +
> +The reset controller API uses these terms with a specific meaning:
> +
> +Reset line
> +
> +    Physical reset line carrying a reset signal from a reset controller
> +    hardware unit to a peripheral module.
> +
> +Reset control
> +
> +    Control method that determines the state of one or multiple reset lines.
> +    Most commonly this is a single bit in reset controller register space that
> +    either allows direct control over the physical state of the reset line, or
> +    is self-clearing and can be used to trigger a predetermined pulse on the
> +    reset line.
> +    In more complicated reset controls, a single trigger action can launch a
> +    carefully timed sequence of pulses on multiple reset lines.
> +
> +Reset controller
> +
> +    A hardware module that provides a number of reset controls to control a
> +    number of reset lines.
> +
> +Reset consumer
> +
> +    Peripheral module or external IC that is put into reset by the signal on a
> +    reset line.
> +
> +Consumer driver interface
> +=========================
> +
> +This interface offers a similar API to the kernel clock framework.

or:
  This interface provides an API that is similar to the kernel clock framework.

> +Consumer drivers use get and put operations to acquire and release reset
> +controls.
> +Functions are provided to assert and deassert the controlled reset lines,
> +trigger reset pulses, or to query reset line status.
> +
> +When requesting reset controls, consumers can use symbolic names for their
> +reset inputs, which are mapped to an actual reset control on an existing reset
> +controller device by the core.
> +
> +A stub version of this API is provided when the reset controller framework is
> +not in use in order to minimise the need to use ifdefs.
> +
> +Shared and exclusive resets
> +---------------------------

[snip]

> +
> +API reference
> +=============
> +
> +The reset controller API is documented here in two parts:
> +the `reset consumer API <#reset-consumer-api>`__ and the `reset controller
> +driver API <#reset-controller-driver-api>`__.
> +
> +Reset consumer API
> +------------------
> +
> +Reset consumers can control a reset line using an opaque reset control handle,
> +which can be obtained from :c:func:`devm_reset_control_get_exclusive` or
> +:c:func:`devm_reset_control_get_shared`.
> +Given the reset control, consumers can call :c:func:`reset_control_assert` and
> +:c:func:`reset_control_deassert`, trigger a reset pulse using
> +:c:func:`reset_control_reset`, or query the reset line status using
> +:c:func:`reset_control_status`.
> +
> +.. kernel-doc:: include/linux/reset.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/reset/core.c
> +   :functions: reset_control_reset
> +               reset_control_assert
> +               reset_control_deassert
> +               reset_control_status
> +               reset_control_acquire
> +               reset_control_release
> +               reset_control_put
> +               of_reset_control_get_count
> +               of_reset_control_array_get
> +               devm_reset_control_array_get
> +               reset_control_get_count
> +
> +Reset controller driver API
> +---------------------------
> +
> +Reset controller drivers are supposed to implement the necessary functions in
> +a static constant structure :c:type:`reset_control_ops`, allocate and fill out
> +a struct :c:type:`reset_controller_dev`, and register it using
> +:c:func:`devm_reset_controller_register`.
> +
> +.. kernel-doc:: include/linux/reset-controller.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/reset/core.c
> +   :functions: of_reset_simple_xlate
> +               reset_controller_register
> +               reset_controller_unregister
> +               devm_reset_controller_register
> +               reset_controller_add_lookup

These header and source files cause a number of kernel-doc warnings
for which I am sending a patch.

thanks.
-- 
~Randy


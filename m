Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DEBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E202075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553612266;
	bh=HDa9yQIGdyk7rLzH2dIT93E/JLxebRle4l/tkbZlCNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MJOfer0Q4E2utk/rI4jdHY/zAb5cOlZh6FPoOH9H8Or82F0mQucyi3/t2t2SK7Fcy
	 VZksVJaCm4BUAMO2jiJZ0xQPzj7ikvKmSq6Skl29o7ODnxRTK3MNApEmigCsz4XgHs
	 roYbI3zQIyladkEbwzxwj3BvE9pyCJ/aK5X469L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfCZO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:57:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38990 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbfCZO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:57:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id f10so11725052otb.6;
        Tue, 26 Mar 2019 07:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2ZsUie9LIAWKkFjqokIh3yi98hJtMp44nazKk9tg8LE=;
        b=naj7mJRiCC1EaD+3w9ewzBCYqklq2C8xA56lzT3LTjg1yKd50/rorwGq+hTYQ6oKNt
         zTFledRF9HwCFM20VmVOHs8ClPjmUaUxzAYqbwGsTbZhBnQ/phFVK3AP7kBvi1TSd/sk
         XcoWLJcfGsKZJy0X8VfLJ8a4C46GW9gRweqGmT+wTisWXEas3hmCTsK6m7SweLUIeJt2
         QCoDsGoMn1dcApqs6qM9dKk+ObOq7N79MCLT1fYzZnK8kErskc6HtGc8oST6irC06mu7
         xX0suyHq3iez9+hJPMp8fMPRDiE5Y4W5kaZtOVQMt/rAU/W2CCwnSuxsVJUeTyGpNrwm
         35Sg==
X-Gm-Message-State: APjAAAUfZHcm1aQFJqFxvEfuriPWuNCxEB25AHCp/h5dtMTKAPJHYD2J
        Z3AaIlxrwPd0EqPwfq1jJBQdhEg=
X-Google-Smtp-Source: APXvYqzc4iuf0tG+uDmvzGWFpjLOxkEnxJhy/1rFkKU2k7cBS6uLc3fytxadGsqfF5NgjWdhAg9p2A==
X-Received: by 2002:a9d:de4:: with SMTP id 91mr20817560ots.5.1553612264046;
        Tue, 26 Mar 2019 07:57:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 33sm8141947ott.44.2019.03.26.07.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 07:57:43 -0700 (PDT)
Date:   Tue, 26 Mar 2019 09:57:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: extcon: Add support for fsa9480 switch
Message-ID: <20190326145742.GA21883@bogus>
References: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
 <20190225165822.2770-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225165822.2770-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 05:58:21PM +0100, Paweł Chmiel wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This patch adds documentation for binding of extcont Fairchild
> Semiconductor FSA9480 microusb switch.
> This usb port accessory detector and switch, can be found for example in
> some Samsung s5pv210 based phones.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../bindings/extcon/extcon-fsa9480.txt        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> new file mode 100644
> index 000000000000..ebced7b18eb5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> @@ -0,0 +1,21 @@
> +FAIRCHILD SEMICONDUCTOR FSA9480 MICROUSB SWITCH
> +
> +The FSA9480 is a USB port accessory detector and switch. The FSA9480 is fully
> +controlled using I2C and enables USB data, stereo and mono audio, video,
> +microphone, and UART data to use a common connector port.
> +
> +Required properties:
> + - compatible : Must be "fcs,fsa9480"
> + - reg : Specifies i2c slave address. Must be 0x25.
> + - interrupt-parent : Phandle to interrupt controller to which interrupt
> +   signal of the chip is connected.

Remove this as it is implicit.

> + - interrupts : Should contain one entry specifying interrupt signal of
> +   interrupt parent to which interrupt pin of the chip is connected.
> +
> + Example:
> +	musb@25 {
> +		compatible = "fcs,fsa9480";
> +		reg = <0x25>;
> +		interrupt-parent = <&gph2>;
> +		interrupts = <7 0>;
> +	};
> \ No newline at end of file

Fix this.

> -- 
> 2.17.1
> 

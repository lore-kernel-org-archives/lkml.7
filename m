Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4CEC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E80C2085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 21:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHJV6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 17:58:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43587 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHJV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 17:58:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so26777558wru.10;
        Sat, 10 Aug 2019 14:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9HKM9K3HL43njYCcY6vOqInMtfbzDaB9eASkJJfruQ=;
        b=iUThwJzo6/R3D8r9w+FbypguBYEuNDOe01nxxYhotqFXRGO2smtZvox8Ra1TPLGd3s
         C1Z4JdXceg+Azq+s4M83acj2AvLP8HxhJg4v9H3lf87I5E/w/k0Y2i32+O8qUCowaocU
         k56Av8twKHln4fSFFvGsQ4zsPw4QCtUjXXb2cpf4KpJptaV6jy73N0v4nMWuQiTQaDUy
         rNkCEvY8WdnKKOXYwFhzJLIGrYM3mJMlfYtOCVic8fHf9AMjVEtA3Dm99JEp22+ReLT/
         JCR3Li6XzQWuFX8M1/5QbEnV2TpK5ZT5eRUvyuYUWmzAN/0tEthDfAbMKd5cJ8QLOhA+
         /zTQ==
X-Gm-Message-State: APjAAAUGTxDar8Xy2QyY/SC30otNo5PGV+I3KuP7iuwzPSViZ9EewU3O
        1Trfhbdz9wfZ8IpSgPzpQjQ=
X-Google-Smtp-Source: APXvYqyV5953tlVYfSNQrY/Za/BWWnls8Tn6aDGoR3zfQywrFQ+MRg/Vdsac8DqIe7uRHHb5+a0h3A==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr11610028wrr.5.1565474325005;
        Sat, 10 Aug 2019 14:58:45 -0700 (PDT)
Received: from tfsielt31850.garage.tyco.com ([79.97.20.138])
        by smtp.gmail.com with ESMTPSA id c15sm40631344wrb.80.2019.08.10.14.58.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 14:58:44 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx7d: sbc-iot-imx7: add recovery for i2c3/4
Date:   Sat, 10 Aug 2019 22:58:17 +0100
Message-Id: <20190810215817.5118-1-git@andred.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807082556.5013-6-philippe.schenker@toradex.com>
References: <20190807082556.5013-6-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Aug 2019 08:26:15 +0000, Philippe Schenker wrote:
> From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>
> - add recovery mode for applicable i2c buses for
>   Colibri iMX7 module.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  arch/arm/boot/dts/imx7-colibri.dtsi | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index a8d992f3e897..2480623c92ff 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -140,8 +140,12 @@
>
>  &i2c1 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c1 &pinctrl_i2c1_int>;
> +	pinctrl-1 = <&pinctrl_i2c1_recovery &pinctrl_i2c1_int>;
> +	scl-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;

scl-gpios should be (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN) since
commit d2d0ad2aec4a ("i2c: imx: use open drain for recovery GPIO")

Otherwise you'll get a boot-time warning:
   enforced open drain please flag it properly in DT/ACPI DSDT/board file

> +	sda-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +
>  	status = "okay";
>
>  	codec: sgtl5000@a {
> @@ -242,8 +246,11 @@
>
>  &i2c4 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c4>;
> +	pinctrl-1 = <&pinctrl_i2c4_recovery>;
> +	scl-gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;

and here, too.

Cheers,
André

Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9002206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhy/sN7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfDBGdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:33:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41959 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDBGdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:33:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id 64so10969338otb.8;
        Mon, 01 Apr 2019 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbJvII5M5WDG0lLg4HKMyigUDKa+R7h5q87O1vts0fs=;
        b=Jhy/sN7oecMRA9dYqjhI61v3rAubjD4j8SasUSx6bX6RmnOWmdui+b53kEoRmq0tMy
         YP99gb1Kd24s4sdtkuJ6MiycXeDJQ9wtbtO3RuLfDZ1HLlBaPwanAWndWtTiLC47aQPx
         BaoPMtrESKO2R5xlkprMv/OuMjc6F/49A+cDGR1TADe80FtWlbCYVJpA+GKWDDq3Gd6Z
         3FYeiG1/AEKVubGGpY3ShITo7qqynlHjatUtpksCrWVKUCdyUWa0m7y6TdmQ1SAdHmgs
         b79KDLYkoUBAcLl2/ZBL4lME1OaNb8gGVBTRYJhRj3U3dGmy1SzTWAzphsP+LLBrBOzl
         +rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbJvII5M5WDG0lLg4HKMyigUDKa+R7h5q87O1vts0fs=;
        b=gnQWRfFi/CO76lXrCTXUANW4XY5rgHoHtBNgVkZLRjuWvfB/MnchfkzUfl/UZYcHCF
         72UbqpsbeW/1iIisAyel9GtaGfFd3nhJeZLqM95bTbGojTDJ8BnaWb6ODCQe4CtT02ID
         vPV0xsRZF2d487OOnaiWinOQUfl1ZKsemcVrvwe1KKe214RcnpswM8+Mqver89qlVsWo
         u23j4R7CioZYK3fPwpyFmwh3YMa0LlVqJiomQKUdLJmi8qAnzIrPLNBdjMTU64P/plsd
         xKBjOoos6f417UUzX958fultFJby2l1DYa+GZt08vVdF7UpcTp9scwLQCr8WuoOrqcwm
         wAaw==
X-Gm-Message-State: APjAAAXgOKypbj/gubu0FJcNp4R1jm190iXv/4J0eXJluENPoAKHUiOg
        mOn5Dr0o53a6rAKqMWzn9ZWhGkhZxO1nEA9G05Y=
X-Google-Smtp-Source: APXvYqwn+lRx0txPRMYnfo5symiScyDMA6mOgHmgxEqC/L7isq/dhQCIaPXaEiGjdptbR6ImuALeto4BnyEs2b07lZM=
X-Received: by 2002:a9d:63d5:: with SMTP id e21mr28769508otl.288.1554186826243;
 Mon, 01 Apr 2019 23:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190401143807.xlz32drk367ogcxh@smtp.gmail.com>
In-Reply-To: <20190401143807.xlz32drk367ogcxh@smtp.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 2 Apr 2019 09:33:34 +0300
Message-ID: <CA+U=Dsq2hAo4DrQOnyVxgqov=UZ8Ch1WmzSrwkMj0zOMLNVFog@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: iio: ad9832: add devicetree documentation
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        stefan.popa@analog.com, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 5:38 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Add a devicetree documentation for the ad9832 direct digital
> synthesizer, waveform generator.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  .../bindings/iio/frequency/ad9832.txt         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/ad9832.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/frequency/ad9832.txt b/Documentation/devicetree/bindings/iio/frequency/ad9832.txt
> new file mode 100644
> index 000000000000..6a35fdff5a48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/ad9832.txt
> @@ -0,0 +1,26 @@
> +Analog Devices AD9832 Direct Digital Synthesizer, Waveform Generator
> +
> +Data sheet:
> +https://www.analog.com/media/en/technical-documentation/data-sheets/AD9832.pdf
> +
> +Required properties:
> +       - compatible : Must be "adi,ad9832"
> +       - reg : SPI chip select number for the device
> +       - spi-max-frequency = Max SPI frequency to use (< 25000000)
> +       - clocks : The clock reference for the DDS output
> +       - clock-names : Must be "mclk"

It's always a good idea to reference other base dt docs.
For SPI you could:

```
For more information on SPI properties, please consult
     Documentation/devicetree/bindings/spi/spi-bus.txt
```

For clock:
```
For more information on clock bindings properties, please consult
     Documentation/devicetree/bindings/clock/clock-bindings.txt
```

For regulator:
```
For more information on regulator bindings properties, please consult
     Documentation/devicetree/bindings/regulator/regulator.txt
```

> +
> +Optional properties:
> +       - avdd-supply:  Definition of the regulator used as analog supply
> +       - dvdd-supply : Definition of the regulator used as digital supply
> +
> +Example:
> +       adi9832-dds@0 {
> +               compatible = "adi,ad9832";
> +               reg = <0>;
> +               spi-max-frequency = <25000000>;
> +               clocks = <&ad9832_mclk>;
> +               clock-names = "mclk";
> +               avdd-suppy = <&avdd>;
> +               dvdd-suppy = <&dvdd>;
> +       };
> --
> 2.20.1
>

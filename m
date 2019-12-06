Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4CCC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ED624659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575623770;
	bh=y6ILhcciKSuJM1a593n3n8Eqnwm9Q4AS+WZPaSSa4Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u0T2+dEuIYBlyD0VRPmnfNLw3Ebt6ARgMDTSWBM2bFe5NBrGPPCnZpah2TmbguFtM
	 /qd39zuHhiCY0UvSCaM39tyedX2vuIBoKCfxcJ8mlaDNleMGiQjjLy4fkv+Io7QtfU
	 zeOZ3v5dPdvXWp9cgdl2cF0/r8yxiaq0kDFaKqlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfLFJQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:16:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46826 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLFJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:16:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so5166146edi.13;
        Fri, 06 Dec 2019 01:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CLhIUnSQb3DuWXz3N42A7JIEyaDX6uaUCV8BfcXUUCU=;
        b=DR+9/YR70lp+Pw+kkVGEMKHYg3DgPgO3NpWn9HiTa6IocSqyr0pUx37p3Del1LmI+9
         YVuZgL40u8cRpP0h3TXGjazlpld4J6ktXUdPb5A3x2sYXCQTMjNWtaL2vH4XyVcDIhCz
         db1oHqO5ZOT7Yb5uJyB/gnsSxamliWRvb/DPFjeSAtT0Ie47MPlpw6OANc0z8UeIZlbX
         J6d59vilxeLjbGhMibDfoDbZ2pYBphrMRBC2FZYg53der5E0hgFEQ0YQGdMI1PIe1ATv
         r2KmWNJkkbYnAnJ8Rlef9z5z9osNixlWqR5QYqxUsyfl84KmqzSRiox6JqHVecmtTZ8x
         L7Mw==
X-Gm-Message-State: APjAAAVJh/WROQS9BtM7XIiXBbOeBYgr1zzlBl0H2Mku04JckHdRKWnF
        lXsvVa1NxYtMALig6JNnVDA=
X-Google-Smtp-Source: APXvYqw3O7n8tTxkxboIFuc77FlpUlH+YxTztIHvP6ctEMe+RUDMybzeng1P3Ox5rIlUaTOFh1xQHQ==
X-Received: by 2002:a17:906:6d58:: with SMTP id a24mr13836696ejt.153.1575623767249;
        Fri, 06 Dec 2019 01:16:07 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id by12sm158488ejb.17.2019.12.06.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 01:16:06 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:16:04 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 3/5] devicetree: mfd: max14577: Add reference to
 max14040_battery.txt descriptions
Message-ID: <20191206091604.GA1917@pi3>
References: <20191205154410.29462-1-matheus@castello.eng.br>
 <20191205154410.29462-4-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205154410.29462-4-matheus@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 12:44:08PM -0300, Matheus Castello wrote:
> max77836 MFD has a fuel gauge that has a low SOC alert feature that is
> described in Documentation/devicetree/bindings/power/supply/max17040_battery.txt.
> Adding the reference to de documentation here.

The subject prefix should be:
dt-bindings: mfd: max14577: ...

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/max14577.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
> index fc6f0f4e8beb..45c7f414aee0 100644
> --- a/Documentation/devicetree/bindings/mfd/max14577.txt
> +++ b/Documentation/devicetree/bindings/mfd/max14577.txt
> @@ -5,6 +5,8 @@ Battery Charger and SFOUT LDO output for powering USB devices. It is
>  interfaced to host controller using I2C.
> 
>  MAX77836 additionally contains PMIC (with two LDO regulators) and Fuel Gauge.
> +For the description of Fuel Gauge low SOC alert interrupt see:
> +power/supply/max17040_battery.txt
> 
> 
>  Required properties:
> --
> 2.24.0.rc2
> 

Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D0C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9F92080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578428053;
	bh=Np4uAfPzehCZsxUKnH7M3GExyXqR94cdrJra78mTd08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H9WWuwgRHRny9M0aB9AmbSo1egmCiHF9K5IFgCC2ezvqvnULS3khSmLoReBmFFpLX
	 0+wQHqI2G0FqUFOryR68bWLA3Xhse9D6rS82VbT9Jw3kfKVz7iSyda1iMfDC/FwUrj
	 lO4e2hHM69Yp8rNNrx5GbmqtCKXjwq4pFf+8uJTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAGUOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:14:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34748 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgAGUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:14:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so696329edw.1;
        Tue, 07 Jan 2020 12:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cj6OnC4YqYTNvb3pcEicnN54BEeDPq18S6hBvoM8yBY=;
        b=uVP/x9x9ydFmW8cCCkrwSRjjbEAv2HlyJ5EzgMZrYL1yiZvSyDHzrZa147iaLdyDZ3
         1ETS0vcbB3T/XCZm6Bg63TFtBpauizibuMqWb2/8D6rihleZMrtfwdoita71bRkVrYUh
         Z+gKQWRjKZO7OR8fsCemwqZAywSDoxbhEbJVIg3ZVviEMMT/lS6dGEjQFLu/+kRl7EYr
         m6zt7BrlShEKRuJyGxw7JC9oG8bQAudRzvygvfXLcdHgy0pHhRIgIvH6BZZrrdPgh8vx
         D4P3RnY6YeyT6DfHkhITbMDzGPVaZ51YA8UpesF40sboPUF2tpcc3pATZ0tbBtJNqUYX
         v5dw==
X-Gm-Message-State: APjAAAXgOv+aG7/1wQbRGpnnU7LANdbknlEwhIz4s5z55PzgRxt/inuD
        wqPEwQUYWY2QG7FGbPqHOsMt10wB
X-Google-Smtp-Source: APXvYqzcuGIUKdEaymd4zEMJHlaqst1TFGezEbWMzGdVSrPg5EGnVz+F/fGV2JQg1SdNlH9/iBz1cQ==
X-Received: by 2002:a50:f391:: with SMTP id g17mr1797161edm.52.1578428049704;
        Tue, 07 Jan 2020 12:14:09 -0800 (PST)
Received: from kozik-book ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id f7sm12301ejq.38.2020.01.07.12.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:14:08 -0800 (PST)
Date:   Tue, 7 Jan 2020 21:14:06 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 02/20] arm64: dts: exynos: Rename Samsung and Exynos
 to lowercase
Message-ID: <20200107201406.GA8636@kozik-book>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200104152107.11407-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 04:20:49PM +0100, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Samsung"
> and "Exynos" names.
> 
> "SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
> names.  Therefore they should be written with lowercase letters starting
> with capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Although advertisement materials usually use uppercase "SAMSUNG", the
> lowercase version is used in all legal aspects (e.g. on Wikipedia and in
> privacy/legal statements on
> https://www.samsung.com/semiconductor/privacy-global/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts         | 2 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts        | 2 +-
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts       | 4 ++--
>  arch/arm64/boot/dts/exynos/exynos7.dtsi               | 2 +-

Applied.

Best regards,
Krzysztof


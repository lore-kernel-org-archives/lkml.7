Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B4C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2406F207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575914180;
	bh=kwBN3Z7vcw8AzPrPy0tnbS78OsStOQbC/eSX5y0cfW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A8kdgVX2VKVF9Q7DQK7JCZPZgNYNEzd/OOkKCwbu2RTjdFLrxCRC48gqO5X1yWfXh
	 enTgTMqKhZmrpRM5SA+TK7QfkoP9FdSYHD5dM+EY7Il5F7+hFXjddLLflr0T0ygfX7
	 V4q8+wRqKQ/6Po1jDe4QfU4TMzb2LKkJbDV1UzNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLIR4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:56:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33534 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:56:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so2830936edq.0;
        Mon, 09 Dec 2019 09:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gi+hOHgs4FbeACcCTQiZTWxm/wZf1RY5AFjxL2lbXlA=;
        b=I7Sr86xNmtbM+dqzQa+PH2PuH9d41cOeVRCu2s1Ew1c1ryrlMOnCq85/ewgS8jh/h4
         Dh9lxPZ1iPIMsruUyzNmsh6F2Auda/pxrSpjDEbswKTNF+DHWY9Q4G4HIAAyf12QTpbF
         66zEghfQ+1YbIUbZppmgUtacW/NqLCGFh7YWMhxayW5vL8CVASgdGMBR8KlZPpSKPLX4
         CAbUy+oDVcwbH5d90QM5abl/7Ku6tdQ/CXhQ4t8XH7QD4TSYNJF7FL8QHGRBsaq/Rged
         VSiaaJbSXon/08if3wZ8FM1ksQ2RQA/CEv9KDYvaNo5oiXfH5R8vAuEfFO2caSqXXKZ3
         Pm8w==
X-Gm-Message-State: APjAAAWZROnMoYsmtWPYp3CmxbEoTOqbf09TF+w9Q920VwxPG6sCTxXz
        yOP8MCabT/TYRmsDt9f80U8=
X-Google-Smtp-Source: APXvYqxibjuMKqfHUp5/cyShtSVtcPbXPbo0Lhkzsi+XqDkOd1hJozuvx/jD2HgO6rz0P1LDl87cRQ==
X-Received: by 2002:a17:906:ccd0:: with SMTP id ot16mr2638134ejb.121.1575914177112;
        Mon, 09 Dec 2019 09:56:17 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id g26sm14541ejc.33.2019.12.09.09.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 09:56:16 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:56:11 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] MAINTAINERS: Include Samsung SoC serial driver in
 Samsung entry
Message-ID: <20191209175611.GB26324@kozik-lap>
References: <20191205200422.5781-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205200422.5781-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:04:22PM +0100, Krzysztof Kozlowski wrote:
> Samsung SoC (S3C, S5P and Exynos) serial driver does not have dedicated
> reviewing person so some patches might be missed be Samsung-related
> folks (e.g. not even reaching Samsung SoC mailing list).  Include them
> in generic Samsung SoC maintainer entry to provide some level of
> reviewing and care.  This will not change handling of patches (via
> serial tree).
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> I am not the author of the code and I do not feel confident in its
> internals so if anyone else would also like to join in taking care
> serial driver, feel free to let me know.
> ---
>  MAINTAINERS | 1 +

Applied to samsung-soc.

Best regards,
Krzysztof


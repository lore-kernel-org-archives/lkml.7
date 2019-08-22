Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2D8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F12F23402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566498926;
	bh=Vneswu6QGlnPMygTZfhEVf9r79CCbYyqXUQwTNVLbKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RMO2FvdjxKAWyN5yAIfMtSm8zzCILDC4V4tJ6dmGZl9l2ugKjAeG27Um3U3pP7A4+
	 shPYXHlmuJE0/s3bdkFaoFp48ura9mHo6OnKkPNRjisz9OmmADFGhna5m3vRYHMmJd
	 IJ4Y/6/m2OwEUt0yPq4MAaoYdf504Bp0hOtzWUmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390833AbfHVSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:35:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54699 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbfHVSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:35:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so6586835wme.4;
        Thu, 22 Aug 2019 11:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tUddt47UVuCta3mgJSc1hmEBY8bqXM8P4CnUZuuCDU=;
        b=o5A2DoorUdMImwz2bgpGjaWYLpE/f0OiAeAvkRt2lokqDVI7YmdKBFGChmlAeE4Hq3
         PuHxeidqdR3Hss5y3ruX1AnOfrNAJB+tu5zmuVg9jbqiAqCOQ+LV8emCoSZps0Rrycv6
         gr0tvfiTnf30EdmwpROMrkLfZnOOvhUaM6an6QgyjimRd3GmBrvh5/+Pub3k9fcFJE6r
         hAolXadODHwlNO5XbC4jSkNCTLEPFlvojt21+E+Djb7kWx5FojHGX5JWV30XXHtKh5zy
         URLCF4VB6p2mKGVd5Ktt3YVzFiPGCbB8ZZF4dbrAc9rN+4gyTELGe60pLAYFEj19WLfp
         E8GA==
X-Gm-Message-State: APjAAAWhWhw9w64SZmcuG07YvTeUr34LHLo/se9GrwxPKE2Qza4ANj2H
        IL+aJjuMqmGev1gaePgfqgU=
X-Google-Smtp-Source: APXvYqzKy1puvqnfw8PmDe+xf37FAc+l4js3Rg5NT3wefojKXtpdPyZtRzBlLGggVQtM3iApxVZLJw==
X-Received: by 2002:a1c:9ec5:: with SMTP id h188mr501768wme.176.1566498922468;
        Thu, 22 Aug 2019 11:35:22 -0700 (PDT)
Received: from kozik-lap ([194.230.147.11])
        by smtp.googlemail.com with ESMTPSA id f197sm819174wme.22.2019.08.22.11.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 11:35:21 -0700 (PDT)
Date:   Thu, 22 Aug 2019 20:35:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 1/3] soc: samsung: Exynos for v5.4
Message-ID: <20190822183519.GA23735@kozik-lap>
References: <20190816163042.6604-1-krzk@kernel.org>
 <CAJKOXPcgZ2_ofZyAeTSxALkALaP-SFNfvNmNPYSPyLzuhpGZ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKOXPcgZ2_ofZyAeTSxALkALaP-SFNfvNmNPYSPyLzuhpGZ0w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:51:09AM +0200, Krzysztof Kozlowski wrote:
> On Fri, 16 Aug 2019 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> >
> >   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-5.4
> >
> > for you to fetch changes up to 40d8aff614f71ab3cab20785b4f213e3802d4e87:
> >
> >   soc: samsung: chipid: Convert exynos-chipid driver to use the regmap API (2019-08-15 20:25:25 +0200)
> >
> > ----------------------------------------------------------------
> > Samsung soc drivers changes for v5.4
> >
> > Add Exynos Chipid driver for identification of product IDs and SoC
> > revisions.  The driver also exposes chipid regmap, later to be used by
> > Exynos Adaptive Supply Voltage driver (adjusting voltages to different
> > revisions of same SoC).
> 
> It turns out that it brings troubles (code is executed on every
> platform polluting logs because it is an initcall, not a driver) so
> Sylwester (submitter) asked to skip the submission.
> 
> Please ignore the pull request.

I talked with Sylwester and Bartlomiej who contributed the chipid driver
and they provided small incremental fixes. The driver is still useful
and in the future it will be expanded towards AVS. Therefore please pull
it or optionally wait a week and I will send incremental pull request
with fixes.

Best regards,
Krzysztof


Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CA3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141E722506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257820;
	bh=Xp5zx1M+QO2/lL5tqivNrE0v2U8OJdY+Y4YNXCQGaHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lh3W0wurLG1p2yjYRGfhhXX2envb6vbSteiNg9wvflyzE4TwKAccnO6PEXkbxBpCi
	 n/axXfhAtHBz3P6jFW+gXb3M65EXlMKGpKXV4l31sbv4Y+Y6h9bio31deAIdSqZ/ft
	 hM69poPnHhZM45DjNIY8yID29cUWUf5SZwjsHfZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfKTNuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:50:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41712 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfKTNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:50:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so14247467pfq.8;
        Wed, 20 Nov 2019 05:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OyieLJ1Q4b4TjminHrLGIRlIaNN2ozqzVE5QUxBBtOE=;
        b=KnULF7DmF9ciBAge9J8scdRDdJd+xwDN/6X2ElSQeQu1App8iy3ZwHb2Iqoqzby+Il
         BXlihsAVi3TY5UzViMlQg5m8x9tcBa3VJjff0ubCS5P6C8IDXRmMvCRzCHEy+qLHbIJQ
         R3ojapZtOFx8j7gIWnS5gPRKUVmPIeHtzpVv3UuUdtgc03NT4Sh8n4gehCcJ2npjbOQf
         J/1ICKSPMi2ucKWncBNEcofC4frr9Kg1IOvoSk9mmNv5+kVWluAjywVJZ3qvPZE98/KW
         G5lzTk/by0iTLqVBe0xK0HhT8hS0NBp8CEUl2BOQ0F4DVqoj6j3t71I/B/Et3J1OvBF5
         yOHg==
X-Gm-Message-State: APjAAAVER8rY9KFaGu/rxhX4kz+mQb4FHq9BLwHLiOS2FLORGBVDLl4P
        tE17W8gn9+fOdGflC1Gao4Y=
X-Google-Smtp-Source: APXvYqznbb6ml/3cJWeJZ7kaQBiiMHytQFDrl8Oth2mMRG8vaWWS54IdG4w6Y8FENZKLCLRDmQ6vbg==
X-Received: by 2002:a63:1360:: with SMTP id 32mr3294515pgt.3.1574257817641;
        Wed, 20 Nov 2019 05:50:17 -0800 (PST)
Received: from kozik-lap ([118.189.143.39])
        by smtp.googlemail.com with ESMTPSA id j7sm26942590pgl.38.2019.11.20.05.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 05:50:16 -0800 (PST)
Date:   Wed, 20 Nov 2019 21:50:12 +0800
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video: Fix Kconfig indentation
Message-ID: <20191120135012.GA17348@kozik-lap>
References: <20191120133838.13132-1-krzk@kernel.org>
 <20191120134546.GA2654@pine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120134546.GA2654@pine>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 08:45:46AM -0500, Daniel Thompson wrote:
> On Wed, Nov 20, 2019 at 09:38:38PM +0800, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> > 	$ sed -e 's/^        /\t/' -i */Kconfig
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> No particular objections but I wonder if this would be better sent to
> trivial@kernel.org .

Thanks for feedback.

I sent to trivial and kernel-janitors my previous version of this
patchset which was not split per-subsystem and there was no feedback.
Few other patches already came through maintainers. If there will be no
reply, I'll send next version through trivial.

Best regards,
Krzysztof


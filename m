Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C0C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B3F204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 09:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BBZ4wwxk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BBZ4wwxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF3JwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 05:52:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfF3Jv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 05:51:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CBC766081E; Sun, 30 Jun 2019 09:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561888318;
        bh=uhE7purehiLfRGmm16YCs5z1Dn73+Wci0UrPhJ7fpLc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BBZ4wwxk4puNPQEZKOK/RfD2euImIGdMdZgmDhU9gmT9vu4FqpcJPhUPpcr3/Jc6x
         u52qMjf+1B4jf/qnyBNWjTliBcBg/DNJQ4Jy0dvLXLntGHbSJaM2MSBwP2q+gTtolm
         L/I4wgl9HxErzjrPqUdpPRhAJ37HVv9XaDVZYK5k=
Received: from x230.qca.qualcomm.com (85-76-112-134-nat.elisa-mobile.fi [85.76.112.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B279160595;
        Sun, 30 Jun 2019 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561888318;
        bh=uhE7purehiLfRGmm16YCs5z1Dn73+Wci0UrPhJ7fpLc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BBZ4wwxk4puNPQEZKOK/RfD2euImIGdMdZgmDhU9gmT9vu4FqpcJPhUPpcr3/Jc6x
         u52qMjf+1B4jf/qnyBNWjTliBcBg/DNJQ4Jy0dvLXLntGHbSJaM2MSBwP2q+gTtolm
         L/I4wgl9HxErzjrPqUdpPRhAJ37HVv9XaDVZYK5k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B279160595
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Philip Li <philip.li@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: buildbot status?
References: <20190628142859.GA4844@lst.de>
Date:   Sun, 30 Jun 2019 12:51:54 +0300
In-Reply-To: <20190628142859.GA4844@lst.de> (Christoph Hellwig's message of
        "Fri, 28 Jun 2019 16:28:59 +0200")
Message-ID: <87h887qu2t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Hi buildbot maintainers,
>
> lately I usually get no, in some case a few very delayed build bot
> results for my repos.  Is this as known issue?

I have the same problem, I did receive few reports on Wednesday but
nothing after that. I rely a lot for buildbot doing build checks on
wireless-drivers patches so I hope it comes back soon.

-- 
Kalle Valo

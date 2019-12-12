Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3A6C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937FF2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y5fgt64o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfLLNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:50:23 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59036 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfLLNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XLmXJp8+ii9eSodSB5zreRiOjChLvck97k4PO2HaBzI=; b=Y5fgt64oeF7OU2lnonzLDrFAz
        sRxQA0O+JkMRFJJOe7sBNjsWY5SPvwist/QHC1bohGmXTJ5SxQ41Vp6eghkPAaD6ZnT+z0HQgf2yr
        onpKUfsa0Fu2JQjzsG6vZAcFT2R2lZCgbZshRKLaBWIWKBqP2/edRtgBX3Fj/0ASU+s/1ZHLPCGrf
        57Ti/8Pxc3l8WTAfK/ldi6fCreN37jwJ+ERJGPL2vkCZioirHruMatwaVJqO1M0qnF/GjK5+m9HY+
        9cpXkBijqEMrGYZrh3vivxDsh+3xYnFY7k6IA8RoDg6kunH9JYXtVpewn/UCsXZNg6ROjitfM4sNQ
        ZnSPt16Cg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:40338)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ifOrC-00070B-1c; Thu, 12 Dec 2019 13:50:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ifOrA-0006rD-6i; Thu, 12 Dec 2019 13:50:16 +0000
Date:   Thu, 12 Dec 2019 13:50:16 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Link: documentation seems to be misplaced
Message-ID: <20191212135016.GH25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that the documentation for the Link: attribute in commit
messages is misplaced in the Documentation/ subtree.

There are two workflows:

1) maintainer committing external patches that have come from a
   mailing list.

2) maintainer committing local patches that have been discussed on
   a mailing list.

While the current documentation seems to target initial setup for
new people becoming maintainers, but it is way less obvious for
existing maintainers or for case 2 - I came across this because I
wanted to add a Link: tag for a discussion on a patch I'd posted,
and could find nothing to describe it.  My grep for it failed:

  grep Link: Documentation/*/*ubmitting*

Surely, the format of the Link: tag should be documented in the
submitting-patches document with all the other attributations that
we define in a commit message, with a reference to that from
Documentation/maintainer/configure-git.rst ?

Thanks to Jiri Kosina for pointing out that it is in configure-git.rst.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

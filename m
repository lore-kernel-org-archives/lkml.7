Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CACC2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137F214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576116070;
	bh=mrLm7hWWGdtEPq9cGYIvyHV5bCojU9MeN4AkSl1wgng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kDP70NM10JV/yI94wdfCAzAPByMw2zDBo8dIrC3jsIP1ullMdxFLPCk8J+uE6MTD5
	 4u54d/7NS+CytT791wLZ8/SYaaPsHJRfj3hA52EDfAltzxg1WuSfRXHjraIpflBH7d
	 Jg1ECNuxONJ3OaHnRgFPA/vnTeQQxpH0gIbrkXuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLLCBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfLLCBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:01:08 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232722077B;
        Thu, 12 Dec 2019 02:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576116068;
        bh=mrLm7hWWGdtEPq9cGYIvyHV5bCojU9MeN4AkSl1wgng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXZxgE+DKBG/qoOnEiDBqi4cB+vAa9DF8tMqPwcCv5iE6Ri8KD/kKZVKAZ4gc/KaO
         1cIi+UK0BKN4kCPeqHDRoonl+3TlmTJpancmus5GZz0xxy25tzYq4bCZLs7EZ7bXjb
         OTITqe06Wl/qWRvaJfI/Z2WK1j8xUftOiF2565ag=
Date:   Thu, 12 Dec 2019 10:00:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] arm64: dts: ls1028a: fix reboot node
Message-ID: <20191212020055.GB15858@dragon>
References: <20191211171145.14736-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211171145.14736-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:11:45PM +0100, Michael Walle wrote:
> The reboot register isn't located inside the DCFG controller, but in its
> own RST controller. Fix it.
> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Michael Walle <michael@walle.cc>

You missed Leo's ACK on v2?  I added it and applied the patch.

Shawn

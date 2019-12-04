Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC91DC2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B5820803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575450337;
	bh=W1t6dNj52ZUG0AupYVqxw7bef+USOAa+be6MpmKrRSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LRjC0TQiN560Mn9RguXo11wx0x7kvl7sxdqPP8Nkh/CxaQaT3RYzSy2DDvWp7jTVN
	 rHAKAhGJhLbUwsuds9ieT6Hp+EqWyzRS9nnw+LGNF1Ft2QqiMwErwWt7/nSGohmgfG
	 pXKSYKqdK23G0th4tcElItZBCIC0hATpR6CgWMXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLDJFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfLDJFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:05:36 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E942073B;
        Wed,  4 Dec 2019 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575450335;
        bh=W1t6dNj52ZUG0AupYVqxw7bef+USOAa+be6MpmKrRSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ye4CL1vchhMhXmU2l2B3AVyoNIjTA2ItW0G/6OMaBc7fpkBQiPTFVaJEQ4tTZ70nw
         hWuQ4ybPwyTm+UTcxCO7XrMYp6BKDDGuOJGI5fWk1nESiZC7b+YvuGktiQdTYY5nzk
         jvnc1JZmnH1ljU2QYYykILnMcqVECwsDAXxSgv/g=
Date:   Wed, 4 Dec 2019 17:05:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx7d-sdb-reva: Add revision in board
 compatible string
Message-ID: <20191204071930.GE3365@dragon>
References: <1573092893-10612-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573092893-10612-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:14:52AM +0800, Anson Huang wrote:
> i.MX7D SDB Rev-A board should use its own board compatible
> string instead of default i.MX7D SDB board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.

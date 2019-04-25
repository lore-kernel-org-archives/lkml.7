Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED902C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD3D20693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556219054;
	bh=OlIuVpiDxWZu7Hhj1q612wWY0KbvcsNi2l9RgPsgAas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cWY30W/juffrJL3OR4PpNVby5szbkthH40lz2ZGTYWPpELJISWO6LRC3PsVhC8+mp
	 i9+LxXKS4jVWy5m8s2U7OnHELuRuNPUS/ZjGc21s5Vz7LYfx5bNLKswW5wyZXzrx9d
	 P8HTO/gBZjU3zu1VMLK1j6HIPTQYp8iX9uhQM5O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfDYTEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfDYTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:04:11 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E459120693;
        Thu, 25 Apr 2019 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556219051;
        bh=OlIuVpiDxWZu7Hhj1q612wWY0KbvcsNi2l9RgPsgAas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQzJn7IYhK6Sw1/8aXeDifTjKQw13iUAo3YtCJGG8Qf2bdD2j4hkoh0tBeapfkXLc
         zDksAtujEzzCNbjanrlsON6Ajey2x2atcFx89rhA3ThkTPrbox0OjKbFCCzRB8cxOF
         WiYn5duaVmo2roEL1Nhr3tnyUkJdXszsoa5m5cTM=
Date:   Thu, 25 Apr 2019 21:04:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] drivers: base: regmap: add proper SPDX identifiers on
 files that did not have them.
Message-ID: <20190425190408.GB22421@kroah.com>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
 <20190425180618.GB8998@kroah.com>
 <20190425185225.GI23183@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425185225.GI23183@sirena.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 07:52:25PM +0100, Mark Brown wrote:
> On Thu, Apr 25, 2019 at 08:06:18PM +0200, Greg Kroah-Hartman wrote:
> > There were a few files in the regmap code that did not have SPDX
> > identifiers on them, so fix that up.  At the same time, remove the "free
> > form" text that specified the license of the file, as that is impossible
> > for any tool to properly parse.
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

"drivers: base: regmap:" was my attempt at doing this, it worked for all
of the other patches in this series :)

I'll drop the first two words and resend, thanks.

greg k-h

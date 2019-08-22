Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDDC23401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566517170;
	bh=h97KeFoQ4IPkGOvpz+652NWjuwd55+sTOa6TbqPPsyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iZiKuRfKse7AWKEEchaY/ACtGLMnJcXoVPf3uujlqroJfPLgw7lKvx25r6pVmLRIN
	 lscxmcVWli/Dmc3xu5LwljFBnSmBkne0cICHw3n8PrTOIN2yN/biybHfD0wxLXqWMS
	 cbKYliX4Ig2nYSSRrrAR6h7fDo32iu06Yke6QzqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHVXj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfHVXj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:39:29 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E1F21848;
        Thu, 22 Aug 2019 23:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566517168;
        bh=h97KeFoQ4IPkGOvpz+652NWjuwd55+sTOa6TbqPPsyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJmiz002uBbMMQRNfM01EykB0x3a4wDpvzA21BOkHosgNB8FD54MsPXZmeMD49hwD
         VChtOLcIg4QNpKhllWa99pW6ITIwvsLvLUTuuljZTbnAQ/ZTGDaCBWAvqY31miMv+Q
         oevnHBn7Q/5qd7/gSd6/DqaO0oTjQk7XN0J/sIE4=
Date:   Thu, 22 Aug 2019 16:39:27 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/71] 4.14.140-stable review
Message-ID: <20190822233927.GC24034@kroah.com>
References: <20190822171726.131957995@linuxfoundation.org>
 <5d5f064d.1c69fb81.ab35c.8cfd@mx.google.com>
 <7h8srk238x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7h8srk238x.fsf@baylibre.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 04:23:58PM -0700, Kevin Hilman wrote:
> "kernelci.org bot" <bot@kernelci.org> writes:
> 
> > stable-rc/linux-4.14.y boot: 124 boots: 2 failed, 106 passed with 16 offline (v4.14.139-72-g6c641edcbe64)
> 
> TL;DR;  All is well.

Thanks for the interpretation of these, that helped a lot.  Glad nothing
is broken :)

greg k-h

Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3135420663
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572113067;
	bh=RnQ7KzIlXLB02GaqoOUCoQODZ8K4G9ZrO4l3ZJNA05o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rOH8COFnLQrbuGbrv0P1MflByR2jP5PiITzGt6l4KWhYPlsjMnLX3wNfweNkccC5Y
	 Wl8CUGZBCfeOaIZum8aSNkYiGO/r+WWIk+H8orAyblkUZePr3BP+x9VVOmwlXbdI09
	 McnwKhIRbbXejmvV0Atiw5PDPNzz0VOpnwgA5ZGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfJZSEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfJZSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:04:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B10620663;
        Sat, 26 Oct 2019 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113063;
        bh=RnQ7KzIlXLB02GaqoOUCoQODZ8K4G9ZrO4l3ZJNA05o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRDglpKhmshWqpZUFWyHziNgFaIvO7xlfyYjjTdLwINaKQW5oATwyC2hbVoN1lEky
         yH5+ZknWGF+sVk9JVlNRwINVoB2HV47KHIa4eQqNm99b9l//9X7c7vxgjQxWbIh1u1
         K4UhTFKPrcQ2jg+nO9aFHLUxFi03lSWpdd32+nFQ=
Date:   Sat, 26 Oct 2019 20:04:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RESEND PATCH 1/2] staging: rtl8712: Fix Alignment of open
 parenthesis
Message-ID: <20191026180421.GB645771@kroah.com>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
 <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:09:38PM -0300, Cristiane Naves wrote:
> Fix alignment should match open parenthesis.Issue found by checkpatch.

Space after a '.' between sentences, right?


thanks

greg k-h

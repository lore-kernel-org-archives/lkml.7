Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F3AC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909FC222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573641920;
	bh=omdYK6XtMhbv1v/RiOXnCMGLXx1Yi9frz/as92P7Dsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kXvzvdKgxtI3r/Zgxs+XQaiRSyNEJO9cjfXz56s6WFmOw1XLJI23R9Z8MxyE75Oj5
	 LxjFH1+fupBdDV/ChfbOREU+/V+BqYM5y3zfInY6+ti3ZLVVlbv4PlFT0kGXJCppxS
	 F7fybSF9iptf7OlYi/RXfyGEiBQpGU+izO+76JCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfKMKpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfKMKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:45:19 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51C4222D0;
        Wed, 13 Nov 2019 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573641917;
        bh=omdYK6XtMhbv1v/RiOXnCMGLXx1Yi9frz/as92P7Dsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT0SxUJqSCwc3KIYye9HuP2ReIeLdY1LEuKYuVRVzn2Ca/25yks9bwuTH/Y1Y5VPg
         JUV9DZpJsKlf5b5WYy1hRg3FCN/81xcEAgJrr3ydZukW8auJKzruoKPjGX9b2ffcdw
         ZwsdnAqYZqyhp198Fn48tpmgiMLRaib2GJ6oTWUQ=
Date:   Wed, 13 Nov 2019 11:45:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Javier F. Arias" <jarias.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging: rtl8723bs: Rename variable
Message-ID: <20191113104515.GC2068945@kroah.com>
References: <61ec6328ccb22696ccc769ce9fbbe26fd00cd04a.1573605920.git.jarias.linux@gmail.com>
 <1610b265f1c6ee0148002642836283fb3757a36f.1573605920.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610b265f1c6ee0148002642836283fb3757a36f.1573605920.git.jarias.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:38:47PM -0500, Javier F. Arias wrote:
> This patch renames a variable name previously defined in uppercase.

That says what you did, but not _why_ you want to do it.


Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A619C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15798204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rsFPGs5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfFXNWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:22:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfFXNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BUnOoXsQ8vI3qS3szXEDs2fAZTjGRFJUpiAXARiLAvk=; b=rsFPGs5h0yaaPiZwsWI3YkZL0
        S+eeHilaw5DqP3wRRFWwZczhNJkLGwjW8cK+fSi6bLTk71+OpS9LOMT/IcLNuwNwKOHIlsH0AZXRV
        zp8B1CHL4OFFAvvEx1YSTotSJV4sn0b5E80ZQzE2PJ7mgIjh8Lhxl3aKjU1eL49qXQhkM5CBhsRUN
        uofWzESi8sDOrxFtRGGZ6INRqnHpRq7ZFcPTdRRBZxMQME15tZkfDt21uOE0+ngd3NrQyfEbYuo/W
        psMsI2feNWLlcfsPV8TlxeSlvX9EjWhfJRQlNsR0rIrylFsw7qRwqR4jjkbIfwCapQLe/a9Uob4IR
        HP0/KGPIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfOvl-00074F-FX; Mon, 24 Jun 2019 13:22:45 +0000
Date:   Mon, 24 Jun 2019 06:22:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add wsync_mode for sysfs entry
Message-ID: <20190624132245.GA12316@infradead.org>
References: <20190621180124.82842-1-jaegeuk@kernel.org>
 <622f5e04-3781-d49a-d65d-a7c244389cb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622f5e04-3781-d49a-d65d-a7c244389cb3@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moreover if it makes sense it should be a generic setting.  Please
Cc Jens who added REQ_BACKGROUND and linux-mm to the cc list so that
we can have a good discussion.

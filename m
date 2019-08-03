Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8EC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 10:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D642166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564828672;
	bh=rvSy+DkFHfJJQs5FO+ssGpIcVBdH8oyIwHeTL/q+uTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tmRoTBBsqOjyOOY0TZwTKWnZr0DdCzRbBC66BatAhKpWV5VGNd2mbc0col1Tw6y+F
	 y/e2cJ8zHOpmfjxmnF4feF3Ck1kpOiGJClaZ+XoaicivtoaZBpD6va7/M4AdBd9Mvv
	 EyCQH+r1CJDe7yhePZ2iYoIA8+azGAI+67LH3cO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfHCKhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 06:37:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfHCKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 06:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lywWmB/x6WbRdpUR+L/zPjYp7f410Ry0vDhEqZpMJ/k=; b=d4ITvMeDkSKOXJwam4ra61CqS
        iuKUqsdOSxinJjOOD3VVqWDyCZc7kJhqHwu4GfGknWgBBu3KS+8Z7Duh0YeGJLZcUp5ltD8TpyjLU
        s/XFlugPeKmxePZ7c+zUJbBAQlZl9iR50W4GTw2dn+4E2EG9KTk0nsArYmGLPWyK+ah9paSIZiKjW
        yc3DpgBv8Bz/ZOaArTm7Vy2JM4ye0CvLj22EENhzhBMYEXFFXSfXJre4gM5TBZ85J0IGJMKPGnqIE
        jW3gYNq5ZTDRKnv5UP8GaVcJDNlZEznVTdz+wFJQoL0i6X+QDtuCP3/ZIXmqnIQFCeV1sba0ZtePs
        t/NJN9uFA==;
Received: from [191.33.150.100] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htrQ5-0003zU-PL; Sat, 03 Aug 2019 10:37:50 +0000
Date:   Sat, 3 Aug 2019 07:37:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "# 3.9+" <stable@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 06/42] scripts/sphinx-pre-install: fix
 script for RHEL/CentOS
Message-ID: <20190803073744.39412f73@coco.lan>
In-Reply-To: <CAJ1xhMWb6OG0xdBtAQZkX-T0XNmMNaMaS=ScJ4ZRwpv9eHXmCQ@mail.gmail.com>
References: <20190802132302.13537-1-sashal@kernel.org>
        <20190802132302.13537-6-sashal@kernel.org>
        <CAJ1xhMWb6OG0xdBtAQZkX-T0XNmMNaMaS=ScJ4ZRwpv9eHXmCQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 3 Aug 2019 13:31:30 +0300
Alexander Kapshuk <alexander.kapshuk@gmail.com> escreveu:

> > -       if (! $system_release =~ /Fedora/) {
> > +       if (!($system_release =~ /Fedora/)) {
> >                 $map{"virtualenv"} = "python-virtualenv";
> >         }
> 
> The negated binding operator '!~' could be used here as well, and it
> does not require the use of extra parenthesis.
> Just a thought.

Thanks for the tip! Never used such operator. Will start using
next time we need to handle a pattern like that.

Thanks,
Mauro

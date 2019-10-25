Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAC6222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572012037;
	bh=gqcWKa5cLQe90gcPgIFByj9D6hhMPg+LCDLFYQP5lGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2h+8VjnNaZdr0l13bkBFGbkAGBvjOnba3D3MXOJkOCL8Kb62xLJQsnw8Xk0q1m8ao
	 XS4oaxyzYx2qIGGmYTnoCXuC+erlgHbR6EcbZ/4BY83WuQs8VElci2w+EnUoTYGCQH
	 OQmRKE8LQeOca3Rjj8FsqSIsHZdCQqbCTkSbm8Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394859AbfJYOAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:00:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393874AbfJYOAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:00:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6889B97F;
        Fri, 25 Oct 2019 14:00:29 +0000 (UTC)
Date:   Fri, 25 Oct 2019 16:00:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025140029.GL17610@dhcp22.suse.cz>
References: <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
 <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
 <20191025120505.GG17610@dhcp22.suse.cz>
 <20191025121104.GH17610@dhcp22.suse.cz>
 <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
 <20191025132700.GJ17610@dhcp22.suse.cz>
 <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
 <20191025135749.GK17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025135749.GK17610@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And one more thing. Considering that you are able to reproduce and you
have a working kernel, could you try to bisect this?
-- 
Michal Hocko
SUSE Labs

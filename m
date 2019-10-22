Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B298CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129B62064A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571732775;
	bh=/Mr/LThIEMJbWlYKkDd18Jd9JL0bjmo5Rvnnvx8XJQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fDb5Wx0JiGQFZWTaOL505KnN8b0y3cq/WqPAN3IJn2kAzBN3Q9x7qX45FZhn85UrQ
	 dq8HhcmpR2fbT2tTSNsA0A7MAF1LV/5n1YlGsJP0zTW5naK0G4mo6ANhRctIT2nhM3
	 Qpwjhkj7waOvsIAo98mfPIXJotmW5KLhiBsGWg9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbfJVI0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:26:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388155AbfJVI0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:26:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB077AFF1;
        Tue, 22 Oct 2019 08:26:11 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:26:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022082611.GD9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz>
 <20191022074615.GA19060@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022074615.GA19060@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 09:46:20, Oscar Salvador wrote:
[...]
> So, opposite to hard-offline, in soft-offline we do not fiddle with pages
> unless we are sure the page is not reachable anymore by any means.

I have to say I do not follow. Is there any _real_ reason for
soft-offline to behave differenttly from MCE (hard-offline)?
-- 
Michal Hocko
SUSE Labs

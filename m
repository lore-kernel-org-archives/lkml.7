Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F03C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E05214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKLJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:49:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfKLJt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:49:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97B26B039;
        Tue, 12 Nov 2019 09:49:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3F48C1E47E5; Tue, 12 Nov 2019 10:49:54 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:49:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: DAX filesystem support on ARMv8
Message-ID: <20191112094954.GC1241@quack2.suse.cz>
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue 12-11-19 02:12:09, Bharat Kumar Gogada wrote:
> As per Documentation/filesystems/dax.txt
> 
> The DAX code does not work correctly on architectures which have virtually
> mapped caches such as ARM, MIPS and SPARC.
> 
> Can anyone please shed light on dax filesystem issue w.r.t ARM architecture ? 

I've CCed Dan, he might have idea what that comment means :)

Out of curiosity, why do you care?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA90BC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BBF21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553164525;
	bh=5qn4OkBhUbT+gR/YDgcNISGjVjOJsRFP9j7x19LggUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yPppovZHjz801rz+KSSXL5T8bp20digbZJw1el9mGmHmuRUjRIFOOJPBt+fcPJmBg
	 LvGOLFchaEARrKNnZmPsRIhBk+UalWn9EVoxzu3Ouik+Fh6xDIsQqncvZcxGIksEOF
	 gi5SxAwlecXsamhpWgbtGrVm8sHbankvIvZ8covI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfCUKfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:35:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbfCUKfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8482ADFF;
        Thu, 21 Mar 2019 10:35:22 +0000 (UTC)
Date:   Thu, 21 Mar 2019 11:35:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190321103521.GO8696@dhcp22.suse.cz>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
 <20190320122011.stuoqugpjdt3d7cd@d104.suse.de>
 <20190320122243.GX19508@bombadil.infradead.org>
 <20190320123658.GF13626@rapoport-lnx>
 <20190320125843.GY19508@bombadil.infradead.org>
 <20190321064029.GW18740@MiWiFi-R3L-srv>
 <20190321092138.GY18740@MiWiFi-R3L-srv>
 <3FFF0A5F-AD27-4F31-8ECF-3B72135CF560@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFF0A5F-AD27-4F31-8ECF-3B72135CF560@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-03-19 04:24:35, William Kucharski wrote:
> 
> 
> > On Mar 21, 2019, at 3:21 AM, Baoquan He <bhe@redhat.com> wrote:
> 
> It appears as is so often the case that the usage has far outpaced the
> documentation and -EEXIST may be the proper code to return.
> 
> The correct answer here may be to modify the documentation to note the
> additional semantic, though if the usage is solely within the kernel it
> may be sufficient to explain its use in the header comment for the
> routine (in this case sparse_add_one_section()).

Is this really worth? It is a well known problem that errno codes are
far from sufficient to describe error codes we need. Yet we are stuck
with them more or less. I really do not see any point changing this
particular path, nor spend a lot of time whether one inappropriate
code is any better than another one. The code works as intended AFAICS.

I would stick with all good rule of thumb. It works, do not touch it too
much.

I am sorry to be snarky but hasn't this generated way much more email
traffic than it really deserves? A simply and trivial clean up in the
beginning that was it, right?
-- 
Michal Hocko
SUSE Labs

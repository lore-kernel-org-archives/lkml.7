Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B645C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0549E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569250240;
	bh=UdlMhhJ5SkpOd5D4DPuVLubNavcu5Uw/XmuanxptrUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uko9sjI7cuRqpoXS9Hjjnacg3GSTM22114/Idy+o4OSi0IZWCuW2M7baBLA+/DsQA
	 rhuc6lhrHqjM7XmQ7df9c3Sk4nLmsexrSlXll25lMnzcC/Vw4CUk3i/RlMvqEy87ND
	 a86L0/Q1ZQIzXTKq+e9WLJeOGASlaXIN3fyKeTP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440115AbfIWOuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:50:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440102AbfIWOuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C6E3AFBF;
        Mon, 23 Sep 2019 14:50:37 +0000 (UTC)
Date:   Mon, 23 Sep 2019 16:50:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     yoav rubin <yoavrubin18@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: linux 32bit kernel virtual space , lowmem , highmem , RAM size
Message-ID: <20190923145037.GA1204@dhcp22.suse.cz>
References: <CAHcr5QqDCjWZz9ADvsE-3tt8qu4K+1NCn-gJuSsm2KBjUcaYVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHcr5QqDCjWZz9ADvsE-3tt8qu4K+1NCn-gJuSsm2KBjUcaYVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-09-19 19:46:46, yoav rubin wrote:
> Apologize in advance if I'm sending this to the wrong place. (It's my
> first time using mailing list...)
> 
> 
> I need some help understanding the exact relations between the linux
> kernel virtual space , specifically LOWMEM area , and the available
> RAM size as seen by the kernel.

Read through https://www.kernel.org/doc/gorman/

[...]
> For this question I'm ignoring the HIGHMEM area since its not exists
> in my system (turned it off by menuconfig).
[...]
> I know that I'm missing something here because there is no way its true.

If you disable highmem then all the 32b kernel can with is lowmem and
that is defined by the split (1/3 low/high).

-- 
Michal Hocko
SUSE Labs

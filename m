Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12ADC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8413F21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576170929;
	bh=Fyb6/fK2KFFxnJ/1P9lp7azi9Ofrz+pj2dxzPQw5ulU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=09IKGNHH/OwcTjpeIdjxblcjuZty0m8/cBw3O+20v4UdYtm47p9YHYwg5HXpONIZL
	 3Glo/fRKL7rvsSHvvEleorZterc6uRX5UdCIWGDdOnB4hi2wP7K0vI4Hr2EPxcYsaG
	 YEsxRMbv7shOTli/+aTHZyW/Ixk+RKopmexnBa40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfLLRP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfLLRP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:15:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E26205C9;
        Thu, 12 Dec 2019 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576170927;
        bh=Fyb6/fK2KFFxnJ/1P9lp7azi9Ofrz+pj2dxzPQw5ulU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFFmym/9D8glzkWKRe71tuNPdLZoFSRdcB9tHMQaveU/6IcN3e6XYfMY3Tkp/IQDd
         BqdBTeWrdSPqwqexM1vDyYzChBi9y8eF+kgvz/nxC8c/MuL8zn06vmEjx2CgqydcMh
         xKE90fqWSfbD91aaxzXx4/FtIuAXenetul2leFbo=
Date:   Thu, 12 Dec 2019 18:15:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        luto@kernel.org, adobriyan@gmail.com, akpm@linux-foundation.org,
        vbabka@suse.cz, peterz@infradead.org, bigeasy@linutronix.de,
        mhocko@suse.com, john.ogness@linutronix.de, nixiaoming@huawei.com
Subject: Re: [PATCH 4.4 0/7] fs/proc: Stop reporting eip and esp in
Message-ID: <20191212171505.GB1681017@kroah.com>
References: <20191202083519.23138-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202083519.23138-1-yi.zhang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 04:35:12PM +0800, zhangyi (F) wrote:
> Reporting eip and esp fields on a non-current task is dangerous,
> so backport this series for 4.4 to fix protential oops and info leak
> problems. The first 3 patch are depended on the 6/7 patch.

Thanks for the backports, now queued up.

greg k-h

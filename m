Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027ACC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68F92054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfE1Nl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:41:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfE1NlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:41:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3C80AF61;
        Tue, 28 May 2019 13:41:24 +0000 (UTC)
Date:   Tue, 28 May 2019 15:41:23 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] intel-svm: fix typos in code comments
Message-ID: <20190528134123.GB8151@suse.de>
References: <20190520050948.26841-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520050948.26841-1-houweitaoo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 01:09:48PM +0800, Weitao Hou wrote:
> fix acccess to access
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
>  include/linux/intel-svm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

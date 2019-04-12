Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C5FC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E272171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDLHHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:07:18 -0400
Received: from retiisi.org.uk ([95.216.213.190]:36064 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfDLHHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:07:18 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 5A051634C7F;
        Fri, 12 Apr 2019 10:06:05 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hEqGE-0003sE-4s; Fri, 12 Apr 2019 10:06:06 +0300
Date:   Fri, 12 Apr 2019 10:06:06 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Akihiro Tsukada <tskd08@gmail.com>,
        linux-kernel@vger.kernel.org, Abylay Ospan <aospan@netup.ru>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sergey Kozlov <serjk@netup.ru>, Mike Isely <isely@pobox.com>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] media: prefix header search paths with $(srctree)/
Message-ID: <20190412070605.kpzsgyopawwj23qc@valkosipuli.retiisi.org.uk>
References: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
 <1548399259-17750-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548399259-17750-4-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 03:54:19PM +0900, Masahiro Yamada wrote:
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
> 
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
> 
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
> 
> [1]: https://patchwork.kernel.org/patch/9632347/
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, Yamada-san!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

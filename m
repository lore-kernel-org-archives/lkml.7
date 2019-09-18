Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7963CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D73121927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568837602;
	bh=5IEjEBIJqu0oLo761zcOugWSggIlKE+XJQ9ZfLBgxv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x9zZP4D+Pkc/RKAJTsNfEz0wqZ4AVr9rwHUs1pc68cXlttTmezuimi93G1tEcXq2A
	 Bc4CVK5NbeTjtd7P4tf2NlX+1KHKEytNAf3wA+R0dFo049/8rjh8EVDhV+5PAvux/r
	 w12Shv95g2lVRj7Q0M6ixbM40SxEVDTmILm41qbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfIRUNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391137AbfIRUNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:13:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01AB9218AE;
        Wed, 18 Sep 2019 20:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568837600;
        bh=5IEjEBIJqu0oLo761zcOugWSggIlKE+XJQ9ZfLBgxv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TigylZRrNnklqsoSyyPeceE5abQuYuzfUnOF3E4GihLzpw7Ww6wpp7xpQxVxVaTVm
         VSLZFtFKlyal09taeseC5ambv1HZZqHKurSsUI6IRnVkmhl6NS1sSLLnrmYe5PmGFa
         sv0JLfGcOBm2HZOPjV7+XK3K4wmM3lBt6Lz6MHYY=
Date:   Wed, 18 Sep 2019 22:13:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Park Ju Hyung <qkrwngud825@gmail.com>
Cc:     alexander.levin@microsoft.com, namjae.jeon@samsung.com,
        sergey.senozhatsky.work@gmail.com, sergey.senozhatsky@gmail.com,
        sj1557.seo@samsung.com, valdis.kletnieks@vt.edu,
        dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
Message-ID: <20190918201318.GB2025570@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190918195920.25210-1-qkrwngud825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918195920.25210-1-qkrwngud825@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:59:20AM +0900, Park Ju Hyung wrote:
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0-or-later

You just changed the license of this file.  Are you SURE about that?

I would like to get a signed-off-by from a samsung developer/lawyer to
have on the record for this, otherwise I can't take such a thing.

thanks,

greg k-h

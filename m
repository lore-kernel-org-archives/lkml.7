Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19394C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D5F2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565983631;
	bh=oPGDIoqZn3Sll+12wBR27GNtA0u2/psTwlY98pea974=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=qbZi4FHmTm+80NH2roKQj73SkVVPyw9AfB33QVK84ZP221KfL/BCXg3CKsP3N3dBs
	 gkliV4OYntkmQ+KpEo01SPURcJQweH4MIJ7npk9J7jpmqoY64ubvXmcYfUGspqR8K+
	 lwTf96y4Ui+kHBy32iHICUFfPCRSO3pJj+jhIMOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfHPT1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfHPT1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:27:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC022133F;
        Fri, 16 Aug 2019 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565983628;
        bh=oPGDIoqZn3Sll+12wBR27GNtA0u2/psTwlY98pea974=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bNtKQLscWo4OBidVtjQylNIgxezPDVGxA4fS/tGrv1WJ5gdYQySgCKS1vaUShTcjS
         MP6uuPCPIN0xqbum0i0Fsdh3nhVvI4BAgmUIZZKO/MsX0CfsRAjbe2/1aq5rAHpz0Q
         FGhqKQXDIkenBgXBlVuwrBdtO4j8SYcZBZ6oehLI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816185716.530013-1-lkundrak@v3.sk>
References: <20190816185716.530013-1-lkundrak@v3.sk>
Subject: Re: [PATCH] clk: tidy up the help tags in Kconfig
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 12:27:07 -0700
Message-Id: <20190816192707.DCC022133F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-08-16 11:57:16)
> Sometimes an extraneous "---help---" follows "help". That is probably a
> copy&paste error stemming from their inconsistent use. Let's just replace
> them all with "help", removing the extra ones along the way.

Can you just send the patch to remove the extra ones? I don't really
care to make it consistent in the same patch.


Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F37C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6F3260D2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfE3Te1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:34:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58906 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3Te0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:34:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 21A1714DA8199;
        Thu, 30 May 2019 12:34:26 -0700 (PDT)
Date:   Thu, 30 May 2019 12:34:25 -0700 (PDT)
Message-Id: <20190530.123425.1339903611009203943.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Joao.Pinto@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH net-next 0/2] net: stmmac: selftests: Two fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1559118521.git.joabreu@synopsys.com>
References: <cover.1559118521.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 12:34:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Wed, 29 May 2019 10:30:24 +0200

> Two fixes reported by kbuild.

Series applied.

Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B17C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098221019
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570665313;
	bh=+ear1z6dI77DUXycLrXhGGViepIu8BJgl/I0ALiDHqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xpUE6zf+7k+luNHt2WHIVFKYhtlSVed0zkgOEsUlHbxSo1nfYbtC2AaiHcUwv94yd
	 WY8BbMK3cB8mRnLEonijWuNwW+dIC/4EksTx7g9v/3/Dv0RWpxfwzemg7gkxSiNheh
	 9RtIil4qORDBPAPRDuDKLMIh9osTW9hoAMYmbB+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfJIXzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbfJIXzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:55:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2438D2086D;
        Wed,  9 Oct 2019 23:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570665311;
        bh=+ear1z6dI77DUXycLrXhGGViepIu8BJgl/I0ALiDHqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZB9N8c2cxPlGKNS8S7XeuPZfGTnKGp45bySTAW7dWQPC9g+6UWOnDeSEnR0RMC3eV
         DxRRTueN0RhXQAODvsKDon9CSx9wH5dE+5l+0yi/W7AoeMbWTbUHFiLUL+ueidbwe/
         /nl2hpZ3X9+BGtJrxcPTXFDXuNtjvXEJNTAUCUvs=
Date:   Wed, 9 Oct 2019 16:55:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v4 0/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
Message-Id: <20191009165510.9b38833c1117c77c0de21c9d@linux-foundation.org>
In-Reply-To: <20191008231831.GB27781@hori.linux.bs1.fc.nec.co.jp>
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
        <9af6b35d-bfbf-7f87-a419-042dff018fdd@oracle.com>
        <20191008231831.GB27781@hori.linux.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 23:18:31 +0000 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:

> I think that this patchset is good enough and ready to be merged.
> Andrew, could you consider queuing this series into your tree?

I'll treat that as an acked-by:.

Do you think 2/2 should be backported into -stable trees?

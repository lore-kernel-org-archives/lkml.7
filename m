Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28ACC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BB222BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564182163;
	bh=uog7xDvm2Trfq+568RxA/iEycB6CRRejnXbrvr8BSdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aHDEufThCL6RteYDLdJE2pvI666SJl2XtqPwCLwjGEuqegT8osH1ho9zEANn8lZRK
	 sEWFoj/VmtxoAvRt3B9n/YMa53lPn4IF+oq8OwI+R0cLLNC77eSk5djMvR95GIXmf8
	 h/bZaBOUJcR1yg75Cu11I90wJ+yvIiME64NUkLs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfGZXCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfGZXCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:02:41 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F11A921994;
        Fri, 26 Jul 2019 23:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564182160;
        bh=uog7xDvm2Trfq+568RxA/iEycB6CRRejnXbrvr8BSdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2UhTedPZgajbGffiDMPEjqh9WvdDSCfJpTpcwge1EckBFQeXPRAAOUE224YbTQlOS
         m3Y7UOcKHobcI4Ihfus2az9muFpUFcpJhLNy22x+4J/gwhKkUZ5lPIp+dPpJjz1Fgv
         rlMlOoGOJE83ZjTF3wGfOM25M+WcnUIekcZo6eTw=
Date:   Fri, 26 Jul 2019 16:02:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 4/4] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Message-Id: <20190726160239.68f538a79913df343308b473@linux-foundation.org>
In-Reply-To: <20190726054654.1623433-5-songliubraving@fb.com>
References: <20190726054654.1623433-1-songliubraving@fb.com>
        <20190726054654.1623433-5-songliubraving@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 22:46:54 -0700 Song Liu <songliubraving@fb.com> wrote:

> This patches uses newly added FOLL_SPLIT_PMD in uprobe. This enables easy
> regroup of huge pmd after the uprobe is disabled (in next patch).

Confused.  There is no "next patch".

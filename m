Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6E8C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2BC21582
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgAFDNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:13:41 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:44264 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727369AbgAFDNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:13:41 -0500
X-Greylist: delayed 1661 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jan 2020 22:13:40 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 0062hOig061663;
        Mon, 6 Jan 2020 10:43:24 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0062gfv8061600;
        Mon, 6 Jan 2020 10:42:41 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 6 Jan 2020
 10:45:15 +0800
Date:   Mon, 6 Jan 2020 10:45:16 +0800
From:   Alan Kao <alankao@andestech.com>
To:     <guoren@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Anup.Patel@wdc.com>,
        <vincent.chen@sifive.com>, <zong.li@sifive.com>,
        <greentime.hu@sifive.com>, <bmeng.cn@gmail.com>,
        <atish.patra@wdc.com>, <linux-arch@vger.kernel.org>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
Message-ID: <20200106024515.GA1021@andestech.com>
References: <20200105025215.2522-1-guoren@kernel.org>
 <20200105025215.2522-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200105025215.2522-2-guoren@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0062gfv8061600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> 128bit-vlen and it's based on linux-5.5-rc4.
> 

According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
that "we plan to only accept patches for new modules or extensions that have
been frozen or ratified by the RISC-V Foundation."

Is v0.8 ratified enough for now?


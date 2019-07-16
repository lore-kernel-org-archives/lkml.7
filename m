Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3ADC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148E42173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbfGPLQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:16:42 -0400
Received: from mail.us.es ([193.147.175.20]:41814 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387619AbfGPLQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:16:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CBE8B20A52D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:16:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BB8CB1150CC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:16:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B01F2A59B; Tue, 16 Jul 2019 13:16:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B31C0A6DA;
        Tue, 16 Jul 2019 13:16:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 16 Jul 2019 13:16:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 82CC84265A2F;
        Tue, 16 Jul 2019 13:16:37 +0200 (CEST)
Date:   Tue, 16 Jul 2019 13:16:37 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingfangsen@huawei.com
Subject: Re: [PATCH v5] net: netfilter: Fix rpfilter dropping vrf packets by
 mistake
Message-ID: <20190716111637.s24hwb6a6bjlhdiq@salvia>
References: <1562039976-203880-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562039976-203880-1-git-send-email-linmiaohe@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:59:36AM +0000, Miaohe Lin wrote:
> When firewalld is enabled with ipv4/ipv6 rpfilter, vrf
> ipv4/ipv6 packets will be dropped. Vrf device will pass
> through netfilter hook twice. One with enslaved device
> and another one with l3 master device. So in device may
> dismatch witch out device because out device is always
> enslaved device.So failed with the check of the rpfilter
> and drop the packets by mistake.

Applied to nf.git, thanks.

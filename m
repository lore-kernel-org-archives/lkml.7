Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CA3C32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E5C20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfHMI60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:58:26 -0400
Received: from correo.us.es ([193.147.175.20]:38928 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfHMI6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:58:24 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AA062C3288
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:58:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9D331115103
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:58:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 91BA11150DA; Tue, 13 Aug 2019 10:58:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 949F2DA704;
        Tue, 13 Aug 2019 10:58:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 13 Aug 2019 10:58:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.218.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 66885411FE54;
        Tue, 13 Aug 2019 10:58:19 +0200 (CEST)
Date:   Tue, 13 Aug 2019 10:58:18 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Florian Westphal <fw@strlen.de>,
        Juanjo Ciarlante <jjciarla@raiz.uncu.edu.ar>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: ip masquerading: Update path to the driver
Message-ID: <20190813085818.4yfcaxfk2xqy32fx@salvia>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813060941.15012-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813060941.15012-1-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:09:41AM +0300, Denis Efremov wrote:
> Update MAINTAINERS record to reflect the filename change
> from ipt_MASQUERADE.c to xt_MASQUERADE.c

This entry is there for historical purpose. I'd suggest you send a
patch to remove it so this just falls under the netfilter section.

Thanks.

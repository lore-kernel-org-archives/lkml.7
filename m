Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921F62085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0LCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:02:23 -0400
Received: from mail.us.es ([193.147.175.20]:60816 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfF0LCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:02:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1C23BB6C6E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:02:19 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0CA3ADA4D0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:02:19 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F07051021B2; Thu, 27 Jun 2019 13:02:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A7527FB37C;
        Thu, 27 Jun 2019 13:02:16 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 27 Jun 2019 13:02:16 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7C4F94265A31;
        Thu, 27 Jun 2019 13:02:16 +0200 (CEST)
Date:   Thu, 27 Jun 2019 13:02:16 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2] net: ethtool: Allow parsing ETHER_FLOW types
 when using flow_rule
Message-ID: <20190627110216.fney5pj2low7vwdw@salvia>
References: <20190627085226.7658-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627085226.7658-1-maxime.chevallier@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:52:26AM +0200, Maxime Chevallier wrote:
> When parsing an ethtool_rx_flow_spec, users can specify an ethernet flow
> which could contain matches based on the ethernet header, such as the
> MAC address, the VLAN tag or the ethertype.
> 
> ETHER_FLOW uses the src and dst ethernet addresses, along with the
> ethertype as keys. Matches based on the vlan tag are also possible, but
> they are specified using the special FLOW_EXT flag.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Acked-by: Pablo Neira Ayuso <pablo@gnumonks.org>

Thanks Maxime.

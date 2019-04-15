Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E1EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144EC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfDOMIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:08:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37538 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:08:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hG0PI-0007K0-Rt; Mon, 15 Apr 2019 14:08:17 +0200
Message-ID: <2e48080fa3a44c01c8c045308e77768bb058c952.camel@sipsolutions.net>
Subject: Re: [PATCH v5.1-rc] iwlwifi: make locking in iwl_mvm_tx_mpdu()
 BH-safe
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Apr 2019 14:08:15 +0200
In-Reply-To: <nycvar.YFH.7.76.1904151404430.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm>
          <24e05607b902e811d1142e3bd345af021fd3d077.camel@sipsolutions.net>
          <nycvar.YFH.7.76.1904151328270.9803@cbobk.fhfr.pm>
         <01d55c5cf513554d9cbdee0b14f9360a8df859c8.camel@sipsolutions.net>
         <nycvar.YFH.7.76.1904151404430.9803@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Given that we don't have a primitive in lockdep to assert this invariant, 
> would you consider queuing the below on top of f5ae2f932e2f in 
> wireless-drivers.git?

I think this would probably go via -next, but sure, I've applied it
internally and we'll let it percolate through the trees as usual.

johannes


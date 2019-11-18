Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E290C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA222071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRKYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:24:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:18925 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfKRKYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:24:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 02:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,319,1569308400"; 
   d="scan'208";a="208807990"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2019 02:24:31 -0800
Message-ID: <5DD272F7.4070008@intel.com>
Date:   Mon, 18 Nov 2019 18:31:19 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Khazhismel Kumykov <khazhy@google.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_balloon: fix shrinker pages_to_free calculation
References: <20191115225557.61847-1-khazhy@google.com> <5DD21784.8020506@intel.com> <20191118002652-mutt-send-email-mst@kernel.org> <5DD24B52.4090603@intel.com> <20191118032416-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191118032416-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2019 04:26 PM, Michael S. Tsirkin wrote:
>
> The order is called VIRTIO_BALLOON_FREE_PAGE_ORDER
> making it sounds like there's a free page
> and that's it order.
>
> Let's rename that hont block?
> So VIRTIO_BALLOON_HINT_BLOCK_ORDER ?
>
> VIRTIO_BALLOON_PAGES_PER_HINT_BLOCK ?

Sounds good.

Best,
Wei

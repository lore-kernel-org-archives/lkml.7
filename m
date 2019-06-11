Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B5C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00A820896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406645AbfFKRzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405972AbfFKRzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:55:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B708430C3183;
        Tue, 11 Jun 2019 17:55:18 +0000 (UTC)
Received: from x1.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A02260565;
        Tue, 11 Jun 2019 17:55:18 +0000 (UTC)
Date:   Tue, 11 Jun 2019 11:55:17 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>
Subject: Re: [PATCHv6 3/3] vfio/mdev: Synchronize device create/remove with
 parent removal
Message-ID: <20190611115517.7a6f9c8f@x1.home>
In-Reply-To: <AM4PR0501MB2260589DAFDA6ECF1E8D6D87D1ED0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <20190603185658.54517-1-parav@mellanox.com>
        <20190603185658.54517-4-parav@mellanox.com>
        <20190604074820.71853cbb.cohuck@redhat.com>
        <AM4PR0501MB2260589DAFDA6ECF1E8D6D87D1ED0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 11 Jun 2019 17:55:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 03:22:37 +0000
Parav Pandit <parav@mellanox.com> wrote:

> Hi Alex,
> 
[snip]
 
> Now that we have all 3 patches reviewed and comments addressed, if
> there are no more comments, can you please take it forward?

Yep, I put it in a branch rolled into linux-next for upstream testing
last week and just sent a pull request to Linus today.  Thanks,

Alex

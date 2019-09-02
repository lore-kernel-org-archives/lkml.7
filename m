Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EEBC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02479215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfIBJXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:23:45 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45099 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfIBJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:23:45 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 04D171BF221;
        Mon,  2 Sep 2019 09:23:41 +0000 (UTC)
Message-ID: <99cffa73439fd0d59fa738d786545f5a6e35ab4d.camel@hadess.net>
Subject: Re: [PATCH v5] hid-logitech-hidpp: read battery voltage from newer
 devices
From:   Bastien Nocera <hadess@hadess.net>
To:     Pedro Vanzella <pedro@pedrovanzella.com>,
        linux-input@vger.kernel.org
Cc:     lains@archlinux.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Sep 2019 11:23:41 +0200
In-Reply-To: <20190831175659.7404-1-pedro@pedrovanzella.com>
References: <20190831175659.7404-1-pedro@pedrovanzella.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-31 at 13:56 -0400, Pedro Vanzella wrote:
> Newer Logitech mice report their battery voltage through feature
> 0x1001
> instead of the battery levels through feature 0x1000.
> 
> When the device is brought up and we try to query the battery, figure
> out if it supports the old or the new feature. If it supports the new
> feature, record the feature index and read the battery voltage and
> its status.

FWIW, it wasn't clear to me that there were 3 bytes, and the last one
would contain the battery status. I was under the impression reading
this that the only thing the mouse would send back would be the
voltage, so this might need a slight rewording.

Did you test this with upower? Did it work as you expected?

Cheers


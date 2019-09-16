Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E8C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA95214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfIPL7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:59:01 -0400
Received: from postamt.cs.uni-dortmund.de ([129.217.4.40]:57648 "EHLO
        postamt.cs.uni-dortmund.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731379AbfIPL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:59:00 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 07:58:58 EDT
Received: from postweb.cs.uni-dortmund.de (postweb [129.217.4.49])
        (authenticated bits=0)
        by postamt.cs.uni-dortmund.de (8.12.6/8.12.6) with ESMTPSA id x8GBrl1q025902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 13:53:47 +0200 (MEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Sep 2019 13:53:47 +0200
From:   Christoph Pleger <christoph.pleger@cs.uni-dortmund.de>
To:     linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org
Subject: Running an application on a new VT
Message-ID: <bbfcbea3f39a4a3689f4ffedf962fbbf@cs.uni-dortmund.de>
X-Sender: christoph.pleger@cs.uni-dortmund.de
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using the program openvt to run another program. openvt is used to 
open a new virtual terminal and then run the given program on the new 
VT. In my case, I want to start a KDE Plasma session on the new VT.

Unfortunately, this did not work as expected: After entering the command 
'openvt -s -w -- dbus-run-session startplasmacompositor', the KDE 
session did not start on the new VT, but on tty1, from where I had 
entered the openvt command. Then, I tried with 'openvt -s -w -- 
/bin/bash', but though this ran bash on a new virtual terminal, entering 
'dbus-run-session startplasmacompositor' on the new VT caused a switch 
back to tty1 and again, the desktop session started there.

Does anybody know why not the new VT is used for the desktop session and 
how that behaviour can be changed?

Regards
   Christoph

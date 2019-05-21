Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CCCC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85CF20863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="WIM0/pWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfEUGOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:14:43 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:15476 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfEUGOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:14:42 -0400
Date:   Tue, 21 May 2019 06:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1558419280;
        bh=mtG9H69zr1exY51a0zHHd7k+CZp/ts+/WXQCtXCcmsU=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=WIM0/pWABShvZ96ZdS6B4MptqGXFn8VUIiLh13xUMvDkJWSgb5Dmk+h+siIEfKcsL
         NR5a8FlB93CMhASvn2ZlWCW6SbJMUPe662VxJYCKLi2bih7xidqABXc+PeALhVeQC/
         eX1HTfV93R3Z9jGtCI5wLPMixISZsmJjobRpmr9U=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: =?UTF-8?B?R07Dmg==?=
Message-ID: <LXNw4HsWw8KcbKJsXhIx7dCYh5KVGbY9c0vK0h1PglmbvY3lYsHHGH65tDPtTHn1KXNP7xUdGBY0uUnbz4IhuEeDK9q1vQ2Swl8BTOiidE0=@protonmail.com>
In-Reply-To: <yj3cJbq2_hCaVXihBLK639mb2Xd_Pu8SxU6-c7vl8IQdoAWyDQb0rRq45ic5C044VB_DLPavdchsizC3CyEyPRRws3hSowyGbFgz5-BbFwk=@protonmail.com>
References: <yj3cJbq2_hCaVXihBLK639mb2Xd_Pu8SxU6-c7vl8IQdoAWyDQb0rRq45ic5C044VB_DLPavdchsizC3CyEyPRRws3hSowyGbFgz5-BbFwk=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microsoft seems to be more and more interested in GNU.

Do you not want to be part of that money?

Indeed, may I suggest a slight stylistic change of GNU, to GN=C3=9A.

Peace,
YC.



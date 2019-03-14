Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF7DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C0B217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cXWprr7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCNR3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:29:49 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:13868 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfCNR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:29:49 -0400
Date:   Thu, 14 Mar 2019 17:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1552584587;
        bh=uKWsMvICSa88VTHg83LvSFzqbjgkO5ooTSBrqVC5BHo=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=cXWprr7WaOKEa9apjrxmqoA1IYSPcmoLTLIE8zDJd5J3Wlx3cwmqIgyRMxakzFLwZ
         pVPTv0gZWtqUxH9N1yWVPIdX3tl30qnVvS8Q/Z6NKzrlGoI685rIhG9Xll8Uc43VH4
         HdY62O4l4nD5d5ZLn5Dwz4wey7i5idFoh3SkQHHg=
To:     Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
From:   Erich Ritz <erich.public@protonmail.com>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Erich Ritz <erich.public@protonmail.com>
Subject: selftests: netfilter: space before tab in indent
Message-ID: <LqctFLDlg59bb_YFfmGlfrGv1yVWHlSXfqdhZi5-SNR-huDPXqveF5yxosSYtGhdfh_9Eb7NhOhpX_f557Wf1YrWF_f1b0ppSAXGpDPYBHo=@protonmail.com>
Feedback-ID: 0SxYgTt50GHob29IGuoMZbNjyRcZtgk14Cnrl3B-E4zbo8s0IqA4Wmp4pOCqjLwXig3ekKuhvu6stBGnIf35qQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When applying the patch to upgrade from 4.19.28 to 4.19.29 I get the follow=
ing output:

$ git diff v4.19.28 v4.19.29 | (cd ../linux-4.19.29/ && git apply -)
<stdin>:6204: space before tab in indent.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "ERROR: Could not reach oth=
er namespace(s)" 1>&2
warning: 1 line adds whitespace errors.

It is caused by this line:

+  =09echo "ERROR: Could not reach other namespace(s)" 1>&2

in commit 5c39e08fc417b91d24d243bc6d1a305e1c38fb9f

Erich

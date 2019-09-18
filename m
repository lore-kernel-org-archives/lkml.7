Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F87FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DCA21920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568813084;
	bh=kmtuLqsXp25Pzyx5e07dlFP/VBX5rncUIclNI68hxAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fi9Q0u4KJLDinVI/LmfEuKB5pu2GkZGM3JuVURwrF/Jhz+om7ok1rgDHwTkGyEQiw
	 DPGJcpODUHcOUihgQkvyEtfvYOR3qPacdNrpUAckA5O7FVq1dXoeDvKNObgxYgBLrl
	 owBQfNI1Cq32eMw19vT59E4m5vCqCktV1/0h6UIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfIRNYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfIRNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:24:42 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61BD820856;
        Wed, 18 Sep 2019 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568813081;
        bh=kmtuLqsXp25Pzyx5e07dlFP/VBX5rncUIclNI68hxAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ov/fbA4mF3qn6h7SEVhwWYSvG/tu4zuxLjrvBuNr+igYmnor2NU0q1hcTwB+GKlTs
         2alpTXwRJM8rAyIKtIlAYEYGoBH06HIEHs7HtYw6xPYAcA9mTgildeCv3oizS3eRGK
         azcDGx6NqICvxZ6ljr8x5QCJndtOhRDWyOmd7UZQ=
Date:   Wed, 18 Sep 2019 15:24:38 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: Fix building error for
 dt_binding_check
Message-ID: <20190918132438.yagtnqghomaksrvd@gilmour>
References: <1568808060-17516-1-git-send-email-pragnesh.patel@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568808060-17516-1-git-send-email-pragnesh.patel@sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 05:31:00PM +0530, Pragnesh Patel wrote:
> $id doesn't match the actual filename, so update the $id
>=20
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

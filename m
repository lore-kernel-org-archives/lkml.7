Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1AC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC620B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfFMO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 10:59:02 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49069 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbfFMOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:54:51 -0400
X-Originating-IP: 90.88.159.246
Received: from localhost (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 28485240010;
        Thu, 13 Jun 2019 14:54:45 +0000 (UTC)
Date:   Thu, 13 Jun 2019 16:54:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: Check the examples against the schemas
Message-ID: <20190613145445.n5i6rkhgddwtjbyo@flea>
References: <20190613144210.22181-1-robh@kernel.org>
 <20190613144210.22181-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f65q35kf44uwfpr2"
Content-Disposition: inline
In-Reply-To: <20190613144210.22181-2-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f65q35kf44uwfpr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2019 at 08:42:10AM -0600, Rob Herring wrote:
> Currently, the binding examples are just built with dtc. dtc recently
> gained the support necessary to output the examples in YAML format
> (commit 87963ee20693 ("livetree: add missing type markers in generated
> overlay properties"). Now just switch the output format and the examples
> will be checked against the schema.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

For both,

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f65q35kf44uwfpr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQJjtQAKCRDj7w1vZxhR
xZxpAQD+Csm6NW6xs3F9ECciXe4YWZlf4NupGE7IECk8c3fZuQEA9vcBhpmeD2UQ
Izl4nblyUMI9q0W1ucyY7sxH36PYfQY=
=jiUn
-----END PGP SIGNATURE-----

--f65q35kf44uwfpr2--

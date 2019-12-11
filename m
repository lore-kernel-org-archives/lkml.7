Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B3C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7520838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q9nLroBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfLKBzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:55:32 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59826 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726500AbfLKBzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:55:03 -0500
X-UUID: 3a3538c7ee23456d8da924ee7262d01e-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DTdqGLNreI4e1sJ9dvMRJhExLHYEoJ4Xe55wfAj33vc=;
        b=Q9nLroBZkZ5vpoA3hQi4E83MuQL+Kv1dgkY9tquHDbcFc2hK1ced5lW5dPCIN+kVugkm3mYfV5/gl8FezwBme/CwRz5kmm+Qox9FLwo0vlvGrnxvpBpwKzpO2wTf/GcbX0xQbSHcB0YdAlSkI/np99PnCfZFv8zmrb7e4UnDLf4=;
X-UUID: 3a3538c7ee23456d8da924ee7262d01e-20191211
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 558557027; Wed, 11 Dec 2019 09:54:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 09:54:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 09:54:47 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>, Min Guo <min.guo@mediatek.com>
Subject: [PATCH v9 1/6] dt-bindings: usb: musb: Add support for MediaTek musb controller
Date:   Wed, 11 Dec 2019 09:54:41 +0800
Message-ID: <20191211015446.11477-2-min.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191211015446.11477-1-min.guo@mediatek.com>
References: <20191211015446.11477-1-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 87FF25A57B59E089C7D4840C86B52E863F4494460E20D7CEF27A07A97310AFC32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWluIEd1byA8bWluLmd1b0BtZWRpYXRlay5jb20+DQoNClRoaXMgYWRkcyBzdXBwb3J0
IGZvciBNZWRpYVRlayBtdXNiIGNvbnRyb2xsZXIgaW4NCmhvc3QsIHBlcmlwaGVyYWwgYW5kIG90
ZyBtb2RlLg0KDQpTaWduZWQtb2ZmLWJ5OiBNaW4gR3VvIDxtaW4uZ3VvQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KY2hhbmdlcyBpbiB2OToNCjEuIEFkZCB1c2Itcm9sZS1zd2l0Y2gNCjIuIFJlbW92ZSBs
YWJlbCBvZiB1c2IgY29ubmVjdG9yIGNoaWxkIG5vZGUNCjMuIENoYW5nZSB1c2IgY29ubmVjdG9y
IGNoaWxkIG5vZGUgY29tcGF0aWJsZSBhcyAiZ3Bpby11c2ItYi1jb25uZWN0b3IiLCAidXNiLWIt
Y29ubmVjdG9yIjsNCg0KY2hhbmdlcyBpbiB2ODoNCjEuIEFkZCByZXZpZXdlZCBieSBSb2INCg0K
Y2hhbmdlcyBpbiB2NzoNCjEuIE1vZGlmeSBjb21wYXRpYmxlIGFzDQotIGNvbXBhdGlibGUgOiBz
aG91bGQgYmUgb25lIG9mOg0KICAgICAgICAgICAgICAgIm1lZGlhdGVrLG10MjcwMS1tdXNiIg0K
ICAgICAgICAgICAgICAgLi4uDQogICAgICAgICAgICAgICBmb2xsb3dlZCBieSAibWVkaWF0ZWss
bXRrLW11c2IiDQoyLiBDaGFuZ2UgdXNiIGNvbm5lY3RvciBjaGlsZCBub2RlIGNvbXBhdGlibGUg
YXMgImdwaW8tdXNiLWItY29ubmVjdG9yIiANCg0KY2hhbmdlcyBpbiB2NjoNCjEuIE1vZGlmeSB1
c2IgY29ubmVjdG9yIGNoaWxkIG5vZGUNCg0KY2hhbmdlcyBpbiB2NToNCnN1Z2dlc3RlZCBieSBS
b2I6DQoxLiBNb2RpZnkgY29tcGF0aWJsZSBhcyANCi0gY29tcGF0aWJsZSA6IHNob3VsZCBiZSBv
bmUgb2Y6DQogICAgICAgICAgICAgICAibWVkaWF0ZWssbXQtMjcwMSINCiAgICAgICAgICAgICAg
IC4uLg0KICAgICAgICAgICAgICAgZm9sbG93ZWQgYnkgIm1lZGlhdGVrLG10ay1tdXNiIg0KMi4g
QWRkIHVzYiBjb25uZWN0b3IgY2hpbGQgbm9kZQ0KDQpjaGFuZ2VzIGluIHY0Og0Kc3VnZ2VzdGVk
IGJ5IFNlcmdlaToNCjEuIFN0cmluZyBhbGlnbm1lbnQNCg0KY2hhbmdlcyBpbiB2MzoNCjEuIG5v
IGNoYW5nZXMNCg0KY2hhbmdlcyBpbiB2MjoNCnN1Z2dlc3RlZCBieSBCaW46DQoxLiBNb2RpZnkg
RFJDIHRvIERSRA0Kc3VnZ2VzdGVkIGJ5IFJvYjoNCjIuIERyb3AgdGhlICI8c29jLW1vZGVsPi1t
dXNiIiBpbiBjb21wYXRpYmxlDQozLiBSZW1vdmUgcGh5LW5hbWVzDQo0LiBBZGQgc3BhY2UgYWZ0
ZXIgY29tbWEgaW4gY2xvY2stbmFtZXMNCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vz
Yi9tZWRpYXRlayxtdXNiLnR4dCB8IDU3ICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNTcgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG11c2IudHh0DQoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG11c2IudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNiLnR4
dA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uMmI4YTg3YzkwZDll
DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL21lZGlhdGVrLG11c2IudHh0DQpAQCAtMCwwICsxLDU3IEBADQorTWVkaWFUZWsgbXVzYiBE
UkQvT1RHIGNvbnRyb2xsZXINCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQorDQorUmVxdWlyZWQgcHJvcGVydGllczoNCisgLSBjb21wYXRpYmxlICAgICAgOiBz
aG91bGQgYmUgb25lIG9mOg0KKyAgICAgICAgICAgICAgICAgICAgICJtZWRpYXRlayxtdDI3MDEt
bXVzYiINCisgICAgICAgICAgICAgICAgICAgICAuLi4NCisgICAgICAgICAgICAgICAgICAgICBm
b2xsb3dlZCBieSAibWVkaWF0ZWssbXRrLW11c2IiDQorIC0gcmVnICAgICAgICAgICAgIDogc3Bl
Y2lmaWVzIHBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgc2l6ZSBvZg0KKyAgICAgICAgICAgICAg
ICAgICAgIHRoZSByZWdpc3RlcnMNCisgLSBpbnRlcnJ1cHRzICAgICAgOiBpbnRlcnJ1cHQgdXNl
ZCBieSBtdXNiIGNvbnRyb2xsZXINCisgLSBpbnRlcnJ1cHQtbmFtZXMgOiBtdXN0IGJlICJtYyIN
CisgLSBwaHlzICAgICAgICAgICAgOiBQSFkgc3BlY2lmaWVyIGZvciB0aGUgT1RHIHBoeQ0KKyAt
IGRyX21vZGUgICAgICAgICA6IHNob3VsZCBiZSBvbmUgb2YgImhvc3QiLCAicGVyaXBoZXJhbCIg
b3IgIm90ZyIsDQorICAgICAgICAgICAgICAgICAgICAgcmVmZXIgdG8gdXNiL2dlbmVyaWMudHh0
DQorIC0gY2xvY2tzICAgICAgICAgIDogYSBsaXN0IG9mIHBoYW5kbGUgKyBjbG9jay1zcGVjaWZp
ZXIgcGFpcnMsIG9uZSBmb3INCisgICAgICAgICAgICAgICAgICAgICBlYWNoIGVudHJ5IGluIGNs
b2NrLW5hbWVzDQorIC0gY2xvY2stbmFtZXMgICAgIDogbXVzdCBjb250YWluICJtYWluIiwgIm1j
dSIsICJ1bml2cGxsIg0KKyAgICAgICAgICAgICAgICAgICAgIGZvciBjbG9ja3Mgb2YgY29udHJv
bGxlcg0KKw0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorIC0gcG93ZXItZG9tYWlucyAgIDogYSBw
aGFuZGxlIHRvIFVTQiBwb3dlciBkb21haW4gbm9kZSB0byBjb250cm9sIFVTQidzDQorICAgICAg
ICAgICAgICAgICAgICAgTVRDTU9TDQorDQorUmVxdWlyZWQgY2hpbGQgbm9kZXM6DQorIHVzYiBj
b25uZWN0b3Igbm9kZSBhcyBkZWZpbmVkIGluIGJpbmRpbmdzL2Nvbm5lY3Rvci91c2ItY29ubmVj
dG9yLnR4dA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorIC0gaWQtZ3Bpb3MgICAgICAgIDogaW5w
dXQgR1BJTyBmb3IgVVNCIElEIHBpbi4NCisgLSB2YnVzLWdwaW9zICAgICAgOiBpbnB1dCBHUElP
IGZvciBVU0IgVkJVUyBwaW4uDQorIC0gdmJ1cy1zdXBwbHkgICAgIDogcmVmZXJlbmNlIHRvIHRo
ZSBWQlVTIHJlZ3VsYXRvciwgbmVlZGVkIHdoZW4gc3VwcG9ydHMNCisgICAgICAgICAgICAgICAg
ICAgICBkdWFsLXJvbGUgbW9kZQ0KKyAtIHVzYi1yb2xlLXN3aXRjaCA6IHVzZSBVU0IgUm9sZSBT
d2l0Y2ggdG8gc3VwcG9ydCBkdWFsLXJvbGUgc3dpdGNoLCBzZWUNCisgICAgICAgICAgICAgICAg
ICAgICB1c2IvZ2VuZXJpYy50eHQuDQorDQorRXhhbXBsZToNCisNCit1c2IyOiB1c2JAMTEyMDAw
MDAgew0KKwljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1tdXNiIiwNCisJCSAgICAgIm1l
ZGlhdGVrLG10ay1tdXNiIjsNCisJcmVnID0gPDAgMHgxMTIwMDAwMCAwIDB4MTAwMD47DQorCWlu
dGVycnVwdHMgPSA8R0lDX1NQSSAzMiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwlpbnRlcnJ1cHQt
bmFtZXMgPSAibWMiOw0KKwlwaHlzID0gPCZ1MnBvcnQyIFBIWV9UWVBFX1VTQjI+Ow0KKwlkcl9t
b2RlID0gIm90ZyI7DQorCWNsb2NrcyA9IDwmcGVyaWNmZyBDTEtfUEVSSV9VU0IwPiwNCisJCSA8
JnBlcmljZmcgQ0xLX1BFUklfVVNCMF9NQ1U+LA0KKwkJIDwmcGVyaWNmZyBDTEtfUEVSSV9VU0Jf
U0xWPjsNCisJY2xvY2stbmFtZXMgPSAibWFpbiIsIm1jdSIsInVuaXZwbGwiOw0KKwlwb3dlci1k
b21haW5zID0gPCZzY3BzeXMgTVQyNzAxX1BPV0VSX0RPTUFJTl9JRlJfTVNDPjsNCisJdXNiLXJv
bGUtc3dpdGNoOw0KKwljb25uZWN0b3J7DQorCQljb21wYXRpYmxlID0gImdwaW8tdXNiLWItY29u
bmVjdG9yIiwgInVzYi1iLWNvbm5lY3RvciI7DQorCQl0eXBlID0gIm1pY3JvIjsNCisJCWlkLWdw
aW9zID0gPCZwaW8gNDQgR1BJT19BQ1RJVkVfSElHSD47DQorCQl2YnVzLXN1cHBseSA9IDwmdXNi
X3ZidXM+Ow0KKwl9Ow0KK307DQotLSANCjIuMjQuMA0K

